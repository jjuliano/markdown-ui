# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for transition UI elements (animations/effects)
    class TransitionElement < BaseElement
      
      def render
        transition_content = extract_transition_content
        
        build_transition_html(transition_content)
      end
      
      private
      
      def extract_transition_content
        case @content
        when Array
          @content.join("\n").strip
        when String
          @content.strip
        else
          ''
        end
      end
      
      def build_transition_html(content)
        transition_html = []
        
        transition_html << %[<div class="#{css_class}"#{html_attributes}>]
        
        if content.empty?
          transition_html << %[  <div>Transition Content</div>]
        else
          # Process content with potential multi-line structure
          if content.include?("\n")
            processed_content = parse_multiline_content(content)
            transition_html << %[  #{processed_content}]
          else
            transition_html << %[  #{escape_html(content)}]
          end
        end
        
        transition_html << %[</div>]
        
        transition_html.join("\n")
      end
      
      def element_name
        'transition'
      end
      
      def css_class
        classes = ['ui']
        
        # Add animation type modifiers
        animation_modifiers = @modifiers & %w[
          scale fade fly slide browse jiggle flash shake pulse tada bounce glow
        ]
        classes.concat(animation_modifiers)
        
        # Add direction modifiers
        direction_modifiers = @modifiers & %w[left right up down in out]
        classes.concat(direction_modifiers)
        
        # Add state modifiers
        state_modifiers = @modifiers & %w[visible hidden animating]
        classes.concat(state_modifiers)
        
        classes << 'transition'
        classes.join(' ')
      end
    end
  end
end