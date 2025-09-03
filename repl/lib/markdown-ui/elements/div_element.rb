# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Generic div element handler for flexible div rendering
    class DivElement < BaseElement

      def render
        # Handle different content formats for div elements
        if @content.is_a?(Array)
          if @content.length >= 2
            # Multiple parts: first is content, rest are CSS classes
            content_html = parse_nested_div_content(@content[0])
            css_classes = @content[1..-1].map(&:downcase)
          elsif @content.length == 1
            # Single content item
            content_html = parse_nested_div_content(@content.first)
            css_classes = []
          else
            # Empty content
            content_html = ''
            css_classes = []
          end
        else
          content_html = parse_nested_div_content(@content)
          css_classes = []
        end

        # Build CSS classes from content parts and modifiers
        classes = []
        # Only include 'ui' if not a tag element (tag elements are labels without ui)
        if !@modifiers.include?('tag')
          classes << 'ui'
        end
        classes.concat(css_classes) if css_classes.any?
        # Only include modifiers that are not the element name itself
        if @modifiers && @modifiers.any?
          # Filter out "tag" modifier which is just the element name
          filtered_modifiers = @modifiers.reject { |m| m.downcase == 'tag' }
          classes.concat(filtered_modifiers)
        end

        # Special case for column elements - always include "column" class
        if @element_name == 'column'
          classes << 'column'
        end

        # Remove empty strings
        classes.reject!(&:empty?)
        filtered_attributes = @attributes

        class_attr = classes.empty? ? '' : %( class="#{classes.join(' ')}")

        # Use filtered attributes for html_attributes
        attr_str = html_attributes_from_hash(filtered_attributes)

        if content_html.empty?
          "<div#{class_attr}#{attr_str}></div>"
        else
          # Add proper formatting for column elements
          if @element_name == 'column' && content_html.include?('<div')
            # Indent the content for proper nesting
            indented_content = content_html.split("\n").map { |line| line.empty? ? line : "  #{line}" }.join("\n")
            "<div#{class_attr}#{attr_str}>\n#{indented_content}\n</div>"
          else
            "<div#{class_attr}#{attr_str}>#{content_html}</div>"
          end
        end
      end

      def parse_nested_div_content(content)
        return '' if content.nil?

        content_str = content.to_s

        # Check if content contains nested UI elements or markdown
        # Look for blockquote patterns (any level), double underscores, single underscores, or multiple lines
        has_nested_pattern = content_str.match?(/^>*>\s*\w+.*:/) || content_str.include?('__') || content_str.include?('_') || content_str.include?("\n")

        if has_nested_pattern
          # Check if this looks like UI element content that needs blockquote markers
          if content_str.match?(/^\w+.*:\n/) && !content_str.match?(/^>\s*\w+.*:/)
            # Add blockquote markers to make it parseable as UI elements
            content_str = content_str.split("\n").map { |line| "> #{line}" }.join("\n")
          end

          # This looks like nested UI elements, parse recursively
          require_relative '../parser'
          parser = MarkdownUI::Parser.new
          parser.parse(content_str)
        else
          # Simple content, just escape HTML
          escape_html(content_str)
        end
      end

      private

      def has_label_modifiers?
        label_modifiers = %w[basic pointing corner ribbon attached floating circular teal pointing left right above below top bottom]
        @modifiers.any? { |m| label_modifiers.include?(m.downcase) }
      end

      def html_attributes_from_hash(attrs)
        return '' if attrs.nil? || attrs.empty?

        attr_strings = attrs.map do |key, value|
          if value.is_a?(Array)
            %( #{key}="#{value.join(' ')}")
          else
            %( #{key}="#{escape_html(value.to_s)}")
          end
        end

        attr_strings.join
      end

      def element_name
        'div'
      end
    end
  end
end
