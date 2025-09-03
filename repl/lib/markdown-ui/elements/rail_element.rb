# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for rail UI elements (side content)
    class RailElement < BaseElement
      
      def render
        rail_content = extract_rail_content
        
        build_rail_html(rail_content)
      end
      
      private
      
      def extract_rail_content
        case @content
        when Array
          @content.join(' ').strip
        when String
          @content.strip
        else
          ''
        end
      end
      
      def build_rail_html(content)
        rail_html = []
        
        rail_html << %[<div class="#{css_class}"#{html_attributes}>]
        
        if content.empty?
          rail_html << %[  <div>Rail Content</div>]
        else
          # Process content with potential markdown
          processed_content = parse_nested_content(content)
          rail_html << %[  #{processed_content}]
        end
        
        rail_html << %[</div>]
        
        rail_html.join("\n")
      end
      
      def element_name
        'rail'
      end
      
      def css_class
        classes = ['ui']
        
        # Add position modifiers
        position_modifiers = @modifiers & %w[left right]
        classes.concat(position_modifiers)
        
        # Add attachment modifiers
        attachment_modifiers = @modifiers & %w[attached top attached bottom]
        classes.concat(attachment_modifiers)
        
        # Add appearance modifiers
        appearance_modifiers = @modifiers & %w[dividing close very close]
        classes.concat(appearance_modifiers)
        
        # Add size modifiers
        size_modifiers = @modifiers & %w[mini tiny small large big huge massive]
        classes.concat(size_modifiers)
        
        classes << 'rail'
        classes.join(' ')
      end
    end
  end
end