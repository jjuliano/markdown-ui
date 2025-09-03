# frozen_string_literal: true

module MarkdownUI
  module Elements
    # Base class for all UI element handlers
    class BaseElement
      attr_reader :content, :modifiers, :attributes
      
      def initialize(content, modifiers = [], attributes = {}, element_name = nil)
        @content = normalize_content(content)
        @modifiers = normalize_modifiers(modifiers)
        @attributes = attributes || {}
        @element_name = element_name
      end
      
      # Must be implemented by subclasses
      def render
        raise NotImplementedError, "#{self.class} must implement #render"
      end
      
      protected
      
      # Get the base CSS class for this element
      def base_class
        "ui #{element_name}"
      end
      
      # Get the element name (e.g., "table", "button")
      def element_name
        @element_name || self.class.name.split('::').last.sub(/Element$/, '').downcase
      end
      
      # Build the full CSS class string
      def css_class
        classes = ['ui']
        classes.concat(@modifiers) if @modifiers.any?
        classes << element_name

        # Merge with any CSS classes from attributes
        if @attributes && @attributes['class']
          custom_classes = Array(@attributes['class'])
          classes.concat(custom_classes)
        end

        classes.join(' ').encode('UTF-8')
      end
      
      # Get HTML attributes as a string
      def html_attributes
        return '' if @attributes.empty?

        # Exclude 'class' and internal attributes since they're handled separately
        internal_attributes = %w[class ui_context]
        filtered_attributes = @attributes.reject { |key, _| internal_attributes.include?(key) }

        return '' if filtered_attributes.empty?

        attr_strings = filtered_attributes.map do |key, value|
          if value.is_a?(Array)
            %[#{key}="#{value.join(' ')}"]
          else
            %[#{key}="#{escape_html(value)}"]
          end
        end

        ' ' + attr_strings.join(' ')
      end
      
      # Build opening tag
      def opening_tag(tag_name = 'div', additional_classes = [])
        classes = css_class
        classes += ' ' + additional_classes.join(' ') if additional_classes.any?

        %[<#{tag_name} class="#{classes}"#{html_attributes}>]
      end

      # Build closing tag
      def closing_tag(tag_name = 'div')
        "</#{tag_name}>"
      end

      # Wrap content in the element's tags
      def wrap_content(inner_html, tag_name = 'div', additional_classes = [])
        opening_tag(tag_name, additional_classes) + inner_html + closing_tag(tag_name)
      end
      
      # Escape HTML in text content
      def escape_html(text)
        return '' if text.nil?

        text.to_s
          .gsub('&', '&amp;')
          .gsub('<', '&lt;')
          .gsub('>', '&gt;')
          .gsub('"', '&quot;')
          .gsub("'", '&#39;')
      end
      
      # Parse content that might contain nested elements or markdown
      def parse_nested_content(text)
        return '' if text.nil? || text.strip.empty?

        # Handle array of content (from nested blockquote parsing)
        if text.is_a?(Array)
          return parse_content_array(text)
        end

        # Enhanced content parsing that handles both inline and blockquote content
        case text
        when String
          if text.include?("\n") && (text.include?('__') || text.include?('_') || text.include?('> '))
            # Multi-line content that may contain nested UI elements - parse recursively
            parse_multiline_with_nested_elements(text)
          elsif text.include?("\n")
            # Multi-line content (from blockquote)
            parse_multiline_content(text)
          elsif text.match?(/^>\s/)
            # Single-line blockquote - render as markdown using custom renderer
            require 'redcarpet'
            # Use the same custom renderer as the parser
            custom_renderer = Class.new(Redcarpet::Render::HTML) do
              def block_quote(text)
                "<div>#{text}</div>"
              end
            end.new
            markdown = Redcarpet::Markdown.new(custom_renderer, autolink: true, tables: true, fenced_code_blocks: true)
            markdown.render(text.strip).strip
          else
            # Simple markdown parsing for common cases
            text.to_s
              .gsub(/\*\*(.*?)\*\*/, '<strong>\1</strong>')  # Bold
              .gsub(/\*(.*?)\*/, '<em>\1</em>')              # Italic
              .gsub(/`(.*?)`/, '<code>\1</code>')            # Code
          end
        else
          text.to_s
        end
      end

      def parse_content_array(content_array)
        # Handle array of content strings
        result = []
        content_array.each do |content|
          result << parse_nested_content(content)
        end
        result.join("\n")
      end

      def parse_multiline_with_nested_elements(text)
        # Parse multiline content that may contain nested UI elements
        # This is called when content has multiple lines and may contain UI syntax
        lines = text.split("\n").map(&:strip).reject(&:empty?)

        if lines.empty?
          return ''
        elsif lines.length == 1
          return parse_nested_content(lines.first)
        else
          # Multiple lines - check if they contain UI elements
          joined_content = lines.join("\n")

          # Look for UI element patterns or blockquotes
          if joined_content.match?(/__\w+.*__/m) || joined_content.match?(/_\w+.*_/m) || joined_content.match?(/^>\s*\w+.*:/m)
            # Contains UI elements - let the parser handle this recursively
            # Return the content as-is for the parser to handle
            joined_content
          elsif lines.any? { |line| line.match?(/^>\s*/) }
            # Contains blockquotes - let the parser handle this recursively
            # Return the content as-is for the parser to handle
            joined_content
          else
            # No UI elements or blockquotes, treat as regular multiline content
            parse_multiline_content(text)
          end
        end
      end
      
      def parse_multiline_content(content_str)
        # Parse multiline content preserving structure
        lines = content_str.split("\n").map(&:strip).reject(&:empty?)
        
        if lines.length == 1
          escape_html(lines.first)
        else
          # Wrap multiple lines in paragraphs
          lines.map { |line| "<p>#{escape_html(line)}</p>" }.join("\n  ")
        end
      end
      
      def is_container_element?
        # Elements that should wrap their content in appropriate HTML structure
        container_elements = %w[grid segment container message card modal form]
        container_elements.include?(element_name)
      end
      
      # Check if a modifier is present
      def has_modifier?(modifier)
        @modifiers.include?(modifier.to_s.downcase)
      end
      
      # Get a specific attribute value
      def get_attribute(key, default = nil)
        @attributes[key.to_s] || @attributes[key.to_sym] || default
      end
      
      # Check if element has an ID
      def has_id?
        get_attribute(:id) || get_attribute('id')
      end
      
      # Get the element's ID
      def element_id
        get_attribute(:id) || get_attribute('id')
      end

      # Check if element has specific modifiers
      def has_any_modifier?(*modifiers)
        modifiers.any? { |mod| has_modifier?(mod) }
      end

      # Get all modifiers matching a pattern
      def modifiers_matching(pattern)
        @modifiers.select { |mod| mod.match?(pattern) }
      end

      # Add a modifier dynamically
      def add_modifier(modifier)
        @modifiers << modifier.to_s.downcase.strip unless @modifiers.include?(modifier.to_s.downcase.strip)
      end

      # Remove a modifier dynamically
      def remove_modifier(modifier)
        @modifiers.delete(modifier.to_s.downcase.strip)
      end

      # Check if element should be rendered inline
      def inline_element?
        %w[icon flag label button].include?(element_name)
      end

      # Get semantic UI size class from modifiers
      def size_class
        size_modifiers = @modifiers & %w[mini tiny small medium large big huge massive]
        size_modifiers.first
      end

      # Get semantic UI color class from modifiers
      def color_class
        color_modifiers = @modifiers & %w[red orange yellow olive green teal blue violet purple pink brown grey black]
        color_modifiers.first
      end
      
      private
      
      def normalize_content(content)
        case content
        when Array
          content.map(&:to_s).map(&:strip)
        when String
          content.strip
        when nil
          ''
        else
          content.to_s.strip
        end
      end
      
      def normalize_modifiers(modifiers)
        Array(modifiers).map(&:to_s).map(&:downcase).map(&:strip).reject(&:empty?)
      end
    end
  end
end