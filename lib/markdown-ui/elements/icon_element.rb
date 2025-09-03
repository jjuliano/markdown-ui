# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for icon UI elements
    class IconElement < BaseElement
      
      def render
        icon_name = extract_icon_name
        
        return '' if icon_name.empty?
        
        build_icon_html(icon_name)
      end
      
      private
      
      def extract_icon_name
        case @content
        when Array
          @content.first.to_s.strip
        when String
          @content.strip
        else
          ''
        end
      end
      
      def build_icon_html(icon_name)
        # Convert icon name to CSS class format
        icon_class = icon_name.downcase.gsub(/[\s_-]+/, ' ')
        
        %[<i class="#{icon_class} #{css_class}"#{html_attributes}></i>]
      end
      
      def element_name
        'icon'
      end
      
      def css_class
        classes = []
        
        # Add size modifiers
        size_modifiers = @modifiers & %w[mini tiny small large big huge massive]
        classes.concat(size_modifiers)
        
        # Add state modifiers
        state_modifiers = @modifiers & %w[disabled loading]
        classes.concat(state_modifiers)
        
        # Add appearance modifiers
        appearance_modifiers = @modifiers & %w[fitted link circular bordered inverted]
        classes.concat(appearance_modifiers)
        
        # Add color modifiers
        color_modifiers = @modifiers & %w[red orange yellow olive green teal blue violet purple pink brown grey black]
        classes.concat(color_modifiers)
        
        # Add rotation/flip modifiers
        transform_modifiers = @modifiers & %w[clockwise counterclockwise horizontally flipped vertically flipped]
        classes.concat(transform_modifiers)
        
        classes << 'icon'
        classes.join(' ')
      end
    end
  end
end