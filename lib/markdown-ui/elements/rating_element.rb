# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for rating UI elements (star ratings)
    class RatingElement < BaseElement
      
      def render
        rating_value, max_rating = extract_rating_values
        
        build_rating_html(rating_value, max_rating)
      end
      
      private
      
      def extract_rating_values
        case @content
        when Array
          rating = @content[0].to_s.strip.to_i
          max_rating = @content[1].to_s.strip.to_i if @content.length > 1
          [rating, max_rating || 5]
        when String
          if @content.include?('/')
            # Format: "3/5" or "4/10"
            parts = @content.split('/')
            [parts[0].to_i, parts[1].to_i]
          elsif @content.include?('|')
            # Format: "3|5"
            parts = @content.split('|')
            [parts[0].to_i, parts[1].to_i]
          else
            # Just the rating value
            [@content.to_i, 5]
          end
        else
          [0, 5]
        end
      end
      
      def build_rating_html(rating_value, max_rating)
        rating_html = []
        
        rating_html << %[<div class="#{css_class}" data-rating="#{rating_value}" data-max-rating="#{max_rating}"#{html_attributes}>]
        
        # Generate star icons
        (1..max_rating).each do |i|
          if i <= rating_value
            # Active/selected star
            rating_html << %[  <i class="icon active"></i>]
          else
            # Inactive star
            rating_html << %[  <i class="icon"></i>]
          end
        end
        
        rating_html << %[</div>]
        
        rating_html.join("\n")
      end
      
      def element_name
        'rating'
      end
      
      def css_class
        classes = ['ui']
        
        # Add icon type modifiers
        icon_modifiers = @modifiers & %w[star heart]
        classes.concat(icon_modifiers)
        
        # Add size modifiers
        size_modifiers = @modifiers & %w[mini tiny small medium large big huge massive]
        classes.concat(size_modifiers)
        
        # Add color modifiers
        color_modifiers = @modifiers & %w[red orange yellow olive green teal blue violet purple pink brown grey black]
        classes.concat(color_modifiers)
        
        # Add state modifiers
        state_modifiers = @modifiers & %w[disabled]
        classes.concat(state_modifiers)
        
        classes << 'rating'
        classes.join(' ')
      end
    end
  end
end