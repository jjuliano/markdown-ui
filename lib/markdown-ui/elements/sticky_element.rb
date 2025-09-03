# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for sticky UI elements (fixed positioning)
    class StickyElement < BaseElement
      
      def render
        sticky_content = extract_sticky_content
        
        build_sticky_html(sticky_content)
      end
      
      private
      
      def extract_sticky_content
        case @content
        when Array
          @content.join("\n").strip
        when String
          @content.strip
        else
          ''
        end
      end
      
      def build_sticky_html(content)
        sticky_html = []
        
        sticky_html << %[<div class="#{css_class}"#{html_attributes}>]
        
        if content.empty?
          sticky_html << %[  <div>Sticky Content</div>]
        else
          # Process content with potential multi-line structure
          if content.include?("\n")
            processed_content = parse_multiline_content(content)
            sticky_html << %[  #{processed_content}]
          else
            sticky_html << %[  #{escape_html(content)}]
          end
        end
        
        sticky_html << %[</div>]
        
        sticky_html.join("\n")
      end
      
      def element_name
        'sticky'
      end
      
      def css_class
        classes = ['ui']
        
        # Add positioning modifiers
        position_modifiers = @modifiers & %w[top bottom]
        classes.concat(position_modifiers)
        
        # Add behavior modifiers
        behavior_modifiers = @modifiers & %w[bound pushing]
        classes.concat(behavior_modifiers)
        
        classes << 'sticky'
        classes.join(' ')
      end
    end
  end
end