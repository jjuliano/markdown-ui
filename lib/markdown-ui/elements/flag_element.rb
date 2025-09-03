# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for flag UI elements
    class FlagElement < BaseElement
      
      def render
        flag_country = extract_flag_country
        
        return '' if flag_country.empty?
        
        build_flag_html(flag_country)
      end
      
      private
      
      def extract_flag_country
        case @content
        when Array
          content = @content.first.to_s.strip
          if content.empty?
            @modifiers.first.to_s
          else
            # Extract country name from content like "AE Flag"
            content.split.first
          end
        when String
          content = @content.strip
          if content.empty?
            @modifiers.first.to_s
          else
            # Extract country name from content like "AE Flag"
            content.split.first
          end
        else
          @modifiers.first.to_s
        end
      end
      
      def build_flag_html(flag_country)
        # Convert country name to CSS class format
        country_class = flag_country.downcase.gsub(/[\s_-]+/, ' ')
        
        %[<i class="#{country_class} #{css_class}"#{html_attributes}></i>]
      end
      
      def element_name
        'flag'
      end
      
      def css_class
        classes = []
        
        # Add size modifiers
        size_modifiers = @modifiers & %w[mini tiny small large big huge massive]
        classes.concat(size_modifiers)
        
        classes << 'flag'
        classes.join(' ')
      end
    end
  end
end