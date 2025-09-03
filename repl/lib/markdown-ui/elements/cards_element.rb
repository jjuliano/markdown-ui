# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    class CardsElement < BaseElement
      def render
        # Parse the content to extract individual card definitions
        card_contents = parse_card_contents

        return '' if card_contents.empty?

        build_cards_html(card_contents)
      end

      private

      def parse_card_contents
        content_str = @content.is_a?(Array) ? @content.join("\n") : @content.to_s
        content_str = content_str.gsub(/\\n/, "\n")

        # Split by "> Card:" patterns (nested blockquote structure)
        card_blocks = content_str.split(/^> Card:/).map(&:strip).reject(&:empty?)

        card_blocks.map do |block|
          lines = block.split("\n").map(&:strip).reject(&:empty?)
          next nil if lines.empty?

          # Remove blockquote markers from lines
          clean_lines = lines.map { |line| line.gsub(/^>\s*/, '') }

          # First line is header, rest is description
          header = clean_lines[0] || ''
          description = clean_lines[1..-1].join(' ')

          { header: header, description: description }
        end.compact
      end

      def build_cards_html(card_contents)
        cards_html = []

        cards_html << %[<div class="#{css_class}"#{html_attributes}>]

        card_contents.each do |card|
          cards_html << %[  <div class="card">]
          cards_html << %[    <div class="content">]
          cards_html << %[      <div class="header">#{escape_html(card[:header].gsub(/\*\*(.*?)\*\*/, '\1'))}</div>]
          unless card[:description].empty?
            cards_html << %[      <div class="description">]
            cards_html << %[        <p>#{escape_html(card[:description])}</p>]
            cards_html << %[      </div>]
          end
          cards_html << %[    </div>]
          cards_html << %[  </div>]
        end

        cards_html << %[</div>]

        cards_html.join("\n") + "\n"
      end

      def element_name
        'cards'
      end
    end
  end
end
