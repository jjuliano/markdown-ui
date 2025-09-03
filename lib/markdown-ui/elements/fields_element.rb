# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for fields UI elements (groups multiple form fields)
    class FieldsElement < BaseElement

      def render
        content_str = @content.is_a?(Array) ? @content.join("\n") : @content.to_s

        # Parse nested markdown elements if present
        if content_str.include?('__')
          require_relative '../parser'
          parser = MarkdownUI::Parser.new
          parsed_content = parser.parse(content_str)
          content_html = parsed_content.strip
        else
          content_html = parse_nested_content(content_str)
        end

        # Wrap content in fields container
        if content_html.include?("\n")
          indented_content = content_html.split("\n").map { |line| line.empty? ? "" : "  #{line}" }.join("\n")
          opening_tag('div') + "\n" + indented_content + "\n" + closing_tag('div') + "\n"
        else
          wrap_content(content_html, 'div') + "\n"
        end
      end

      def element_name
        'fields'
      end

      def css_class
        classes = []

        # Add state modifiers
        state_modifiers = @modifiers & %w[equal]
        classes.concat(state_modifiers)

        # Add width modifiers
        width_modifiers = @modifiers & %w[
          one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen
          wide
        ]
        classes.concat(width_modifiers)

        classes << 'fields'
        classes.join(' ')
      end
    end
  end
end
