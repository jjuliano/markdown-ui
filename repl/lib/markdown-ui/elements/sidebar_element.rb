# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for sidebar UI elements
    class SidebarElement < BaseElement
      
      def render
        sidebar_content = extract_sidebar_content
        
        build_sidebar_html(sidebar_content)
      end
      
      private
      
      def extract_sidebar_content
        case @content
        when Array
          @content.join("\n").strip
        when String
          @content.strip
        else
          ''
        end
      end
      
      def build_sidebar_html(content)
        sidebar_html = []
        
        sidebar_html << %[<div class="#{css_class}"#{html_attributes}>]
        
        if content.empty?
          sidebar_html << %[  <div>Sidebar Content</div>]
        else
          # Process content with potential multi-line structure
          if content.include?("\n")
            processed_content = parse_multiline_content(content)
            sidebar_html << %[  #{processed_content}]
          else
            sidebar_html << %[  #{escape_html(content)}]
          end
        end
        
        sidebar_html << %[</div>]
        
        sidebar_html.join("\n")
      end
      
      def element_name
        'sidebar'
      end
      
      def css_class
        classes = ['ui']
        
        # Add direction modifiers
        direction_modifiers = @modifiers & %w[left right top bottom]
        classes.concat(direction_modifiers)
        
        # Add state modifiers
        state_modifiers = @modifiers & %w[visible hidden]
        classes.concat(state_modifiers)
        
        # Add animation modifiers
        animation_modifiers = @modifiers & %w[overlay push scale down rotate along]
        classes.concat(animation_modifiers)
        
        # Add appearance modifiers
        appearance_modifiers = @modifiers & %w[inverted labeled icon vertical]
        classes.concat(appearance_modifiers)
        
        # Add size modifiers
        size_modifiers = @modifiers & %w[thin very thin wide very wide]
        classes.concat(size_modifiers)
        
        classes << 'sidebar'
        classes.join(' ')
      end
    end
  end
end