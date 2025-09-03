# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for content UI elements
    class ContentElement < BaseElement
      
      def render
        content_text = extract_content_text
        
        build_content_html(content_text)
      end
      
      private
      
      def extract_content_text
        case @content
        when Array
          @content.join(' ').strip
        when String
          @content.strip
        else
          ''
        end
      end
      
      def build_content_html(content_text)
        if content_text.empty?
          %[<div class="#{css_class}"#{html_attributes}></div>]
        else
          %[<div class="#{css_class}"#{html_attributes}>#{escape_html(content_text)}</div>]
        end
      end
      
      def element_name
        'content'
      end
      
      def css_class
        classes = []
        
        # Add alignment modifiers
        alignment_modifiers = @modifiers & %w[left aligned center aligned right aligned justified]
        classes.concat(alignment_modifiers)
        
        # Add appearance modifiers
        appearance_modifiers = @modifiers & %w[extra image meta description header]
        classes.concat(appearance_modifiers)
        
        # Add spacing modifiers
        spacing_modifiers = @modifiers & %w[hidden fitted]
        classes.concat(spacing_modifiers)
        
        classes << 'content'
        classes.join(' ')
      end
    end
  end
end