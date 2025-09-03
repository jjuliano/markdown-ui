# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for shape UI elements (3D transformations)
    class ShapeElement < BaseElement
      
      def render
        sides = extract_shape_sides
        
        build_shape_html(sides)
      end
      
      private
      
      def extract_shape_sides
        case @content
        when Array
          @content.map(&:to_s).map(&:strip).reject(&:empty?)
        when String
          if @content.include?('|')
            @content.split('|').map(&:strip).reject(&:empty?)
          else
            [@content.strip].reject(&:empty?)
          end
        else
          []
        end
      end
      
      def build_shape_html(sides)
        shape_html = []
        
        shape_html << %[<div class="#{css_class}"#{html_attributes}>]
        
        # Add shape sides
        if sides.any?
          shape_html << %[  <div class="sides">]
          
          sides.each_with_index do |side_content, index|
            side_class = index == 0 ? "active side" : "side"
            shape_html << %[    <div class="#{side_class}">]
            shape_html << %[      #{escape_html(side_content)}]
            shape_html << %[    </div>]
          end
          
          shape_html << %[  </div>]
        else
          # Default sides
          shape_html << %[  <div class="sides">]
          shape_html << %[    <div class="active side">Side 1</div>]
          shape_html << %[    <div class="side">Side 2</div>]
          shape_html << %[  </div>]
        end
        
        shape_html << %[</div>]
        
        shape_html.join("\n")
      end
      
      def element_name
        'shape'
      end
      
      def css_class
        classes = ['ui']
        
        # Add animation modifiers
        animation_modifiers = @modifiers & %w[animating]
        classes.concat(animation_modifiers)
        
        # Add size modifiers
        size_modifiers = @modifiers & %w[mini tiny small medium large big huge massive]
        classes.concat(size_modifiers)
        
        classes << 'shape'
        classes.join(' ')
      end
    end
  end
end