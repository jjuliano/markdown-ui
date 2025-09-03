# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    class ModalElement < BaseElement
      def render
        content_html = parse_modal_content
        # Custom formatting for modal to match expected output
        opening_tag('div') + "\n" + content_html + "\n" + closing_tag('div')
      end

      def element_name
        'modal'
      end

      private

      def parse_modal_content
        content_str = @content.is_a?(Array) ? @content.join("\n") : @content.to_s

        # Split content into lines and parse structure
        lines = content_str.split("\n").map(&:strip).reject(&:empty?)

        header = nil
        content_parts = []
        actions = []

        lines.each do |line|
          if line.match?(/\*\*.*?\*\*/) && header.nil?
            # Extract bold text as header
            header_match = line.match(/\*\*(.*?)\*\*/)
            header = header_match[1] if header_match
          elsif line.match?(/^__Button/)
            # This is a button/action
            actions << line
          elsif line.match?(/^>*>\s*\w+.*:/)
            # This is a UI element (blockquote syntax) - parse recursively
            require_relative '../parser'
            parser = MarkdownUI::Parser.new
            parsed_element = parser.parse(line)
            content_parts << parsed_element.strip
          elsif line.match?(/^!\[.*?\]\(.*?\)/)
            # This is an image - parse it
            image_match = line.match(/^!\[(.*?)\]\((.*?)(?:\s+"(.*?)")?\)/)
            if image_match
              alt_text = image_match[1]
              src = image_match[2]
              # For image modals, create complete image HTML as one part
              image_html = "<div class=\"image\">\n    <img src=\"#{escape_html(src)}\" alt=\"#{escape_html(alt_text)}\" />\n  </div>"
              content_parts << image_html
            end
          else
            # Regular content
            content_parts << line unless line.empty?
          end
        end

        # Build HTML structure
        html_parts = []

        # For image modals, put image first, then header, then content
        image_parts = []
        text_parts = []

        content_parts.each do |part|
          if part.include?("<div class=\"image\">")
            image_parts << part
          else
            text_parts << part
          end
        end

        # Add image if present
        image_parts.each do |image_part|
          html_parts << image_part
        end

        # Add header if present
        if header
          html_parts << "<div class=\"header\">#{escape_html(header)}</div>"
        end

        # Add content if present
        unless text_parts.empty?
          content_html = text_parts.map do |part|
            "<p>#{escape_html(part)}</p>"
          end.join("\n  ")
          html_parts << "<div class=\"content\">"
          html_parts << "  #{content_html}"
          html_parts << "</div>"
        end

        # Add actions if present
        unless actions.empty?
          html_parts << "<div class=\"actions\">"
          actions.each do |action|
            # Parse button syntax and render
            if action.match?(/^__Button\|/)
              button_match = action.match(/^__Button\|([^|]+)(?:\|(.+))?__/)
              if button_match
                button_text = button_match[1]
                button_modifiers = button_match[2] ? button_match[2].split('|') : []
                button_classes = ['ui'] + button_modifiers.map(&:strip) + ['button']
                html_parts << "  <button class=\"#{button_classes.join(' ')}\">#{escape_html(button_text)}</button>"
              end
            end
          end
          html_parts << "</div>"
        end

        # Join parts with proper formatting
        formatted_parts = html_parts.map { |part| "  #{part}" }
        result = formatted_parts.join("\n")

        # Keep newlines between buttons as expected by tests
        # result.gsub!(/(<\/button>)\n\s*(<button)/, '\1\2')

        result
      end
    end
  end
end