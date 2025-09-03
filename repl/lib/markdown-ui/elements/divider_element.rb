# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for divider UI elements
    class DividerElement < BaseElement
      
      def render
        divider_text = extract_divider_text

        build_divider_html(divider_text)
      end

      def inline_element?
        true # Dividers are typically inline elements
      end
      
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
      
      private
      
      def extract_divider_text
        case @content
        when Array
          text = @content.join("\n").strip
        when String
          text = @content.strip
        else
          return ''
        end

        # Strip surrounding quotes if present (markdown formatting)
        if text.match?(/^"(.*)"$/)
          text = text[1..-2]
        end

        # Parse nested content (including blockquotes)
        text = parse_nested_content(text)

        text
      end
      
      def parse_icons_in_text(text)
        # Handle _Icon Name_ format by converting to HTML
        lines = text.split("\n")
        parsed_lines = []
        
        lines.each do |line|
          if line.match?(/^_(.+)_$/) && line.downcase.include?('icon')
            # Parse _Tag Icon_ -> <i class="tag icon"></i>
            icon_text = line.match(/^_(.+)_$/)[1]
            if icon_text.downcase.match?(/(.+)\s+icon/i)
              icon_name = icon_text.match(/(.+)\s+icon/i)[1].strip.downcase
              parsed_lines << "<i class=\"#{icon_name} icon\"></i>"
            else
              parsed_lines << line
            end
          else
            parsed_lines << line
          end
        end
        
        parsed_lines.join("\n")
      end
      
      def build_divider_html(divider_text)
        # Treat HTML entities like &nbsp; as empty content
        is_empty = divider_text.empty? || divider_text.strip.match?(/^&nbsp;$/)

        if is_empty
          %[<div class="#{css_class}"#{html_attributes}></div>]
        else
          # Check if content already contains HTML (like icons or blockquotes)
          contains_html = divider_text.include?('<i class="') || divider_text.include?('<div>')
          
          if contains_html
            # Content already has HTML, don't wrap in <p> tags or escape
            %[<div class="#{css_class}"#{html_attributes}>#{divider_text}</div>]
          elsif @modifiers.include?('header')
            # If this is a header divider, wrap content in <p> tags
            %[<div class="#{css_class}"#{html_attributes}><p>#{escape_html(divider_text)}</p></div>]
          else
            %[<div class="#{css_class}"#{html_attributes}>#{escape_html(divider_text)}</div>]
          end
        end
      end
      
      def element_name
        'divider'
      end
    end
  end
end