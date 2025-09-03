# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for placeholder UI elements
    class PlaceholderElement < BaseElement
      
      def render
        placeholder_content = extract_placeholder_content
        
        build_placeholder_html(placeholder_content)
      end
      
      private
      
      def extract_placeholder_content
        case @content
        when Array
          @content.join("\n")
        when String
          @content
        else
          ''
        end
      end
      
      def build_placeholder_html(content)
        placeholder_html = []
        
        placeholder_html << %[<div class="#{css_class}"#{html_attributes}>]
        
        if content.include?("\n") || has_modifier?('paragraph')
          # Multiple lines - create paragraph placeholders
          lines = content.split("\n").map(&:strip).reject(&:empty?)
          lines.each_with_index do |line, index|
            if line.match?(/^(header|image):/i)
              # Special placeholder types
              type = line.split(':').first.downcase
              placeholder_html << build_special_placeholder(type)
            else
              # Regular line placeholder
              placeholder_html << %[  <div class="line"></div>]
            end
          end
        elsif has_modifier?('image')
          # Image placeholder
          placeholder_html << %[  <div class="image"></div>]
        elsif has_modifier?('header')
          # Header placeholder
          placeholder_html << %[  <div class="header"></div>]
        else
          # Default line placeholders
          lines_count = determine_lines_count
          lines_count.times do
            placeholder_html << %[  <div class="line"></div>]
          end
        end
        
        placeholder_html << %[</div>]
        placeholder_html.join("\n")
      end
      
      def build_special_placeholder(type)
        case type
        when 'image'
          %[  <div class="image"></div>]
        when 'header'
          %[  <div class="header"></div>]
        else
          %[  <div class="line"></div>]
        end
      end
      
      def determine_lines_count
        # Check for number in content or modifiers
        content_str = @content.to_s
        if content_str.match?(/\d+/)
          content_str.match(/\d+/)[0].to_i
        elsif @modifiers.find { |m| m.match?(/\d+/) }
          @modifiers.find { |m| m.match?(/\d+/) }.to_i
        else
          3 # Default to 3 lines
        end
      end
      
      def element_name
        'placeholder'
      end
      
      def css_class
        classes = ['ui']
        
        # Add type modifiers
        type_modifiers = @modifiers & %w[paragraph image header fluid]
        classes.concat(type_modifiers)
        
        # Add state modifiers
        state_modifiers = @modifiers & %w[active loading]
        classes.concat(state_modifiers)
        
        classes << 'placeholder'
        classes.join(' ')
      end
    end
  end
end