# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for step UI elements
    class StepElement < BaseElement
      
      def render
        step_content = extract_step_content
        icon_name = extract_icon
        title = extract_title
        description = extract_description
        
        build_step_html(step_content, icon_name, title, description)
      end
      
      private
      
      def extract_step_content
        case @content
        when Array
          @content.join('|').strip
        when String
          @content.strip
        else
          ''
        end
      end
      
      def extract_icon
        content_str = extract_step_content
        if content_str.match?(/Icon:\s*([^|]+)/i)
          content_str.match(/Icon:\s*([^|]+)/i)[1].strip
        end
      end
      
      def extract_title
        content_str = extract_step_content
        if content_str.match?(/Title:\s*([^|]+)/i)
          content_str.match(/Title:\s*([^|]+)/i)[1].strip
        elsif content_str.include?('|')
          # First non-icon part might be title
          parts = content_str.split('|')
          title_part = parts.find { |p| !p.match?(/^(Icon|Description):/i) }
          title_part&.strip
        else
          content_str unless content_str.match?(/^(Icon|Description):/i)
        end
      end
      
      def extract_description
        content_str = extract_step_content
        if content_str.match?(/Description:\s*([^|]+)/i)
          content_str.match(/Description:\s*([^|]+)/i)[1].strip
        end
      end
      
      def build_step_html(content, icon_name, title, description)
        content_html = []
        
        # Add icon
        if icon_name && !icon_name.empty?
          content_html << %[<i class="#{icon_name.downcase.gsub(' ', ' ')} icon"></i>]
        end
        
        # Add content div
        content_div = []
        if title && !title.empty?
          content_div << %[<div class="title">#{escape_html(title)}</div>]
        end
        if description && !description.empty?
          content_div << %[<div class="description">#{escape_html(description)}</div>]
        end
        
        unless content_div.empty?
          content_html << %[<div class="content">#{content_div.join}</div>]
        end
        
        %[<div class="#{css_class}"#{html_attributes}>#{content_html.join}</div>]
      end
      
      def element_name
        'step'
      end
      
      def css_class
        classes = ['ui']
        
        # Add state modifiers
        state_modifiers = @modifiers & %w[active completed disabled]
        classes.concat(state_modifiers)
        
        # Add appearance modifiers
        appearance_modifiers = @modifiers & %w[vertical ordered stackable fluid]
        classes.concat(appearance_modifiers)
        
        # Add size modifiers
        size_modifiers = @modifiers & %w[mini tiny small large big huge massive]
        classes.concat(size_modifiers)
        
        classes << 'step'
        classes.join(' ')
      end
    end
  end
end