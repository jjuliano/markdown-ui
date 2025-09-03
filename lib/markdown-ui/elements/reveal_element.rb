# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for reveal UI elements (hover effects)
    class RevealElement < BaseElement
      
      def render
        visible_content, hidden_content = extract_reveal_content
        
        build_reveal_html(visible_content, hidden_content)
      end
      
      private
      
      def extract_reveal_content
        case @content
        when Array
          if @content.length >= 2
            [@content[0].to_s.strip, @content[1].to_s.strip]
          else
            [@content[0].to_s.strip, '']
          end
        when String
          if @content.include?('|')
            parts = @content.split('|', 2)
            [parts[0].to_s.strip, parts[1].to_s.strip]
          else
            [@content.strip, '']
          end
        else
          ['', '']
        end
      end
      
      def build_reveal_html(visible_content, hidden_content)
        reveal_html = []
        
        reveal_html << %[<div class="#{css_class}"#{html_attributes}>]
        
        # Visible content
        reveal_html << %[  <div class="visible content">]
        if visible_content.empty?
          reveal_html << %[    <div>Visible Content</div>]
        else
          reveal_html << %[    #{escape_html(visible_content)}]
        end
        reveal_html << %[  </div>]
        
        # Hidden content (revealed on hover/focus)
        reveal_html << %[  <div class="hidden content">]
        if hidden_content.empty?
          reveal_html << %[    <div>Hidden Content</div>]
        else
          reveal_html << %[    #{escape_html(hidden_content)}]
        end
        reveal_html << %[  </div>]
        
        reveal_html << %[</div>]
        
        reveal_html.join("\n")
      end
      
      def element_name
        'reveal'
      end
      
      def css_class
        classes = ['ui']
        
        # Add reveal type modifiers
        type_modifiers = @modifiers & %w[fade move rotate]
        classes.concat(type_modifiers)
        
        # Add direction modifiers for move reveals
        direction_modifiers = @modifiers & %w[left right up down]
        classes.concat(direction_modifiers)
        
        # Add state modifiers
        state_modifiers = @modifiers & %w[active disabled]
        classes.concat(state_modifiers)
        
        # Add size modifiers
        size_modifiers = @modifiers & %w[mini tiny small medium large big huge massive]
        classes.concat(size_modifiers)
        
        classes << 'reveal'
        classes.join(' ')
      end
    end
  end
end