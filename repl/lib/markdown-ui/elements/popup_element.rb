# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for popup UI elements
    class PopupElement < BaseElement
      
      def render
        trigger_text = extract_trigger_text
        popup_content = extract_popup_content
        
        build_popup_html(trigger_text, popup_content)
      end
      
      private
      
      def extract_trigger_text
        case @content
        when Array
          @content.first.to_s.strip
        when String
          if @content.include?(':')
            @content.split(':', 2).first.to_s.strip
          else
            @content.strip
          end
        else
          ''
        end
      end
      
      def extract_popup_content
        case @content
        when Array
          @content[1..-1].join(' ').strip if @content.length > 1
        when String
          if @content.include?(':')
            parts = @content.split(':', 2)
            parts[1].to_s.strip if parts.length > 1
          end
        end || ''
      end
      
      def build_popup_html(trigger_text, popup_content)
        popup_html = []
        
        # Trigger element
        popup_html << %[<div class="#{trigger_class}" data-tooltip="#{escape_html(popup_content)}" data-position="#{popup_position}"#{html_attributes}>]
        popup_html << %[  #{escape_html(trigger_text)}]
        popup_html << %[</div>]
        
        popup_html.join("\n")
      end
      
      def generate_popup_id
        "popup_#{Random.rand(10000)}"
      end
      
      def trigger_class
        classes = []
        
        # Add trigger styling
        if has_modifier?('button')
          classes = ['ui', 'button']
        elsif has_modifier?('icon')
          classes = ['ui', 'icon']
        else
          classes = ['ui', 'popup-trigger']
        end
        
        # Add size and color modifiers
        style_modifiers = @modifiers & %w[
          mini tiny small medium large big huge massive
          red orange yellow olive green teal blue violet purple pink brown grey black
          basic primary secondary
        ]
        classes.concat(style_modifiers)
        
        classes.join(' ')
      end
      
      def popup_position
        # Extract position from modifiers
        positions = @modifiers & %w[
          top bottom left right
          top-left top-right bottom-left bottom-right
          left-center right-center top-center bottom-center
        ]
        
        positions.first || 'top center'
      end
      
      def element_name
        'popup'
      end
    end
  end
end