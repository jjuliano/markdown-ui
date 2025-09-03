# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for field UI elements (form fields)
    class FieldElement < BaseElement
      
      def render
        field_label = extract_field_label
        field_content = extract_field_content
        
        build_field_html(field_label, field_content)
      end
      
      private
      
      def extract_field_label
        case @content
        when Array
          @content.first.to_s.strip
        when String
          if @content.include?('|')
            @content.split('|').first.to_s.strip
          else
            @content.strip
          end
        else
          ''
        end
      end
      
      def extract_field_content
        case @content
        when Array
          @content[1..-1] if @content.length > 1
        when String
          if @content.include?('|')
            parts = @content.split('|')
            parts[1..-1] if parts.length > 1
          else
            nil
          end
        else
          nil
        end
      end
      
      def build_field_html(label, content_parts)
        field_html = []

        field_html << %[<div class="#{css_class}"#{html_attributes}>]

        # Add label if provided
        unless label.empty?
          field_html << %[  <label>#{escape_html(label)}</label>]
        end

        # Add field content (could be input, dropdown, etc.)
        if content_parts && !content_parts.empty?
          content_parts.each do |part|
            part_str = part.to_s.strip
            if part_str.include?('__')
              # Parse nested markdown elements
              require_relative '../parser'
              parser = MarkdownUI::Parser.new
              parsed_content = parser.parse(part_str).strip
              # Remove the outer div wrapper if it exists to avoid double nesting
              if parsed_content.start_with?('<div') && parsed_content.strip.end_with?('</div>')
                # Extract content without the outer div
                inner_content = parsed_content.sub(/^<div[^>]*>/, '').sub(/<\/div>\s*$/, '').strip
                field_html << %[  #{inner_content}]
              else
                field_html << %[  #{parsed_content}]
              end
            else
              field_html << %[  #{escape_html(part_str)}]
            end
          end
        end

        field_html << %[</div>]

        field_html.join("\n")
      end
      
      def element_name
        'field'
      end
      
      def css_class
        classes = []
        
        # Add state modifiers
        state_modifiers = @modifiers & %w[required disabled error]
        classes.concat(state_modifiers)
        
        # Add width modifiers
        width_modifiers = @modifiers & %w[
          one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen
          wide
        ]
        classes.concat(width_modifiers)
        
        # Add type modifiers
        type_modifiers = @modifiers & %w[inline grouped]
        classes.concat(type_modifiers)
        
        classes << 'field'
        classes.join(' ')
      end
    end
  end
end