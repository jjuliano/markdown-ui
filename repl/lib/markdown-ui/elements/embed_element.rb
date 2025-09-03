# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for embed UI elements (videos, maps, etc.)
    class EmbedElement < BaseElement
      
      def render
        embed_url, placeholder_content = extract_embed_content
        
        build_embed_html(embed_url, placeholder_content)
      end
      
      private
      
      def extract_embed_content
        case @content
        when Array
          url = @content[0].to_s.strip
          placeholder = @content[1].to_s.strip if @content.length > 1
          [url, placeholder || '']
        when String
          if @content.include?('|')
            parts = @content.split('|', 2)
            [parts[0].strip, parts[1].strip]
          else
            [@content.strip, '']
          end
        else
          ['', '']
        end
      end
      
      def build_embed_html(embed_url, placeholder_content)
        embed_html = []
        
        embed_html << %[<div class="#{css_class}"#{html_attributes}>]
        
        # Add embed URL as data attribute
        unless embed_url.empty?
          embed_html[0] = embed_html[0].sub(/>$/, %[ data-url="#{escape_html(embed_url)}">])
        end
        
        # Add placeholder content if provided
        unless placeholder_content.empty?
          embed_html << %[  <div class="placeholder">]
          embed_html << %[    #{escape_html(placeholder_content)}]
          embed_html << %[  </div>]
        end
        
        # Add embed element for semantic structure
        unless embed_url.empty?
          if embed_url.include?('youtube') || embed_url.include?('vimeo')
            embed_html << %[  <div class="embed">]
            embed_html << %[    <iframe src="#{escape_html(embed_url)}" frameborder="0" allowfullscreen></iframe>]
            embed_html << %[  </div>]
          else
            embed_html << %[  <div class="embed">]
            embed_html << %[    <iframe src="#{escape_html(embed_url)}" frameborder="0"></iframe>]
            embed_html << %[  </div>]
          end
        end
        
        embed_html << %[</div>]
        
        embed_html.join("\n")
      end
      
      def element_name
        'embed'
      end
      
      def css_class
        classes = ['ui']
        
        # Add aspect ratio modifiers
        ratio_modifiers = @modifiers & %w[4:3 16:9 21:9]
        classes.concat(ratio_modifiers.map { |r| r.gsub(':', ' by ') })
        
        # Add state modifiers
        state_modifiers = @modifiers & %w[active]
        classes.concat(state_modifiers)
        
        classes << 'embed'
        classes.join(' ')
      end
    end
  end
end