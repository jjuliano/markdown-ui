# frozen_string_literal: true

require 'redcarpet'
require 'cgi'

module MarkdownUI
  module Renderers
    # Custom Redcarpet renderer that understands UI element syntax within blockquotes
    class UIAwareRenderer < Redcarpet::Render::HTML
      def initialize(options = {})
        super(options)
        @element_registry = options[:element_registry]
        @nesting_stack = []
      end

      def block_quote(quote)
        # Clean up the quote content
        content = quote.strip

        # Check if this blockquote represents a UI element
        # Look for patterns like "<p>Element:</p>" or "Element:" at the start
        if content.match?(/<p>(\w+.*?):<\/p>/m) || content.match?(/^(\w+.*?):\s*$/m) || content.match?(/^(\w+.*?):\s*\n/m)
          # Extract element info, handling both HTML and plain text
          element_match = nil
          if content.match?(/<p>(\w+.*?):<\/p>/m)
            # HTML wrapped element
            element_match = content.match(/<p>(\w+.*?):<\/p>\s*(.*?)$/m)
          else
            # Plain text element
            element_match = content.match(/^(\w+.*?):\s*(.*?)$/m)
          end

          if element_match
            element_name = CGI.unescapeHTML(element_match[1].strip.downcase)
            element_content = element_match[2].strip

            # Parse modifiers from element name (e.g., "Primary Button" -> name: "button", modifiers: ["primary"])
            name_parts = element_name.split(/\s+/)

            # Known UI elements (same as tokenizer)
            known_elements = %w[
              accordion advertisement breadcrumb button buttons card checkbox column comment container content
              dimmer divider dropdown embed feed field fields flag form grid header icon image input
              item label list loader menu message modal placeholder popup progress rail rating
              reveal search segment shape sidebar statistic step sticky tab table transition
            ]

            # Find the actual element name
            base_name = nil
            modifiers = []

            # Look for known element from right to left
            name_parts.reverse.each do |part|
              if known_elements.include?(part.downcase)
                base_name = part.downcase
                modifiers = name_parts.map(&:downcase) - [base_name]
                break
              end
            end

            # Fallback to first word
            base_name ||= name_parts.first&.downcase || 'div'

            # Generate UI element HTML
            if @element_registry
              begin
                return @element_registry.render(base_name, element_content, modifiers, {})
              rescue
                # Fallback to regular blockquote if element rendering fails
                return "<blockquote>#{content}</blockquote>"
              end
            else
              # No element registry available - generate basic UI element
              css_classes = ['ui'] + modifiers + [base_name]
              return <<~HTML
<div class="#{css_classes.join(' ')}">
#{element_content.empty? ? '' : "<p>#{CGI.escapeHTML(element_content)}</p>"}
</div>
              HTML
            end
          end
        else
          # Regular blockquote content
          "<blockquote>#{content}</blockquote>"
        end
      end

      # Override paragraph to handle special UI element patterns
      def paragraph(text)
        # Check if this paragraph contains inline UI element syntax
        if text.match?(/__([^_]+(?:\|[^_]*)*?)__/) || text.match?(/_([^_]+(?:\|[^_]*)*?)_/)
          # Contains inline UI elements - process them
          process_inline_ui_elements(text)
        else
          # Regular paragraph
          "<p>#{text}</p>"
        end
      end

      private

      def process_inline_ui_elements(text)
        # Process double underscore syntax
        result = text.gsub(/__([^_]+(?:\|[^_]*)*?)__/) do |match|
          content = $1
          render_inline_ui_element(content)
        end

        # Process single underscore syntax
        result = result.gsub(/_([^_]+(?:\|[^_]*)*?)_/) do |match|
          content = $1
          render_inline_ui_element(content)
        end

        "<p>#{result}</p>"
      end

      def render_inline_ui_element(content)
        # Parse the inline element (same logic as tokenizer)
        parts = content.split('|')
        element_name = parts[0]&.strip
        element_content = parts[1..-1]

        # Basic element rendering for inline elements
        if element_name
          name_parts = element_name.downcase.split(/\s+/)
          known_elements = %w[button label icon flag image input]

          base_name = name_parts.find { |part| known_elements.include?(part) } || name_parts.first
          modifiers = name_parts - [base_name]

          css_classes = ['ui'] + modifiers + [base_name]

          case base_name
          when 'button'
            "<button class=\"#{css_classes.join(' ')}\">#{CGI.escapeHTML(element_content.first || element_name)}</button>"
          when 'label'
            "<div class=\"#{css_classes.join(' ')}\">#{CGI.escapeHTML(element_content.first || element_name)}</div>"
          when 'icon'
            "<i class=\"#{element_content.first || element_name} icon\"></i>"
          else
            "<span class=\"#{css_classes.join(' ')}\">#{CGI.escapeHTML(element_content.first || element_name)}</span>"
          end
        else
          content
        end
      end
    end
  end
end