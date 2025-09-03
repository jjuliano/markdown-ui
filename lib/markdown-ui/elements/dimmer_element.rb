# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for dimmer UI elements (overlay effects)
    class DimmerElement < BaseElement
      
      def render
        dimmer_content = extract_dimmer_content
        
        build_dimmer_html(dimmer_content)
      end
      
      private
      
      def extract_dimmer_content
        case @content
        when Array
          @content.join(' ').strip
        when String
          @content.strip
        else
          ''
        end
      end
      
      def build_dimmer_html(content)
        dimmer_html = []
        
        dimmer_html << %[<div class="#{css_class}"#{html_attributes}>]
        
        # Add dimmer content if provided
        unless content.empty?
          dimmer_html << %[  <div class="content">]
          dimmer_html << %[    <div class="center">]
          
          # Check if content looks like a header
          if content.match?(/^#+\s/) || has_modifier?('header')
            dimmer_html << %[      <h2 class="ui inverted header">#{escape_html(content)}</h2>]
          else
            dimmer_html << %[      #{escape_html(content)}]
          end
          
          dimmer_html << %[    </div>]
          dimmer_html << %[  </div>]
        end
        
        dimmer_html << %[</div>]
        
        dimmer_html.join("\n")
      end
      
      def element_name
        'dimmer'
      end
      
      def css_class
        classes = ['ui']
        
        # Add state modifiers
        state_modifiers = @modifiers & %w[active]
        classes.concat(state_modifiers)
        
        # Add type modifiers
        type_modifiers = @modifiers & %w[page segment inverted]
        classes.concat(type_modifiers)
        
        classes << 'dimmer'
        classes.join(' ')
      end
    end
  end
end