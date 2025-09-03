# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for advertisement UI elements (ad spaces)
    class AdvertisementElement < BaseElement
      
      def render
        ad_content, ad_type = extract_advertisement_content
        
        build_advertisement_html(ad_content, ad_type)
      end
      
      private
      
      def extract_advertisement_content
        case @content
        when Array
          content = @content[0].to_s.strip
          ad_type = @content[1].to_s.strip if @content.length > 1
          [content, ad_type || '']
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
      
      def build_advertisement_html(ad_content, ad_type)
        ad_html = []
        
        ad_html << %[<div class="#{css_class}"#{html_attributes}>]
        
        # Add ad type as data attribute if provided
        unless ad_type.empty?
          ad_html[0] = ad_html[0].sub(/>$/, %[ data-type="#{escape_html(ad_type)}">])
        end
        
        if ad_content.empty?
          # Default advertisement placeholder
          ad_html << %[  <div class="content">]
          ad_html << %[    <div class="center">Advertisement</div>]
          ad_html << %[  </div>]
        else
          ad_html << %[  <div class="content">]
          ad_html << %[    #{escape_html(ad_content)}]
          ad_html << %[  </div>]
        end
        
        ad_html << %[</div>]
        
        ad_html.join("\n")
      end
      
      def element_name
        'advertisement'
      end
      
      def css_class
        classes = ['ui']
        
        # Add size modifiers
        size_modifiers = @modifiers & %w[
          medium rectangle large rectangle vertical banner leaderboard
          mobile banner large mobile banner tablet leaderboard
          small rectangle square button small button
          skyscraper wide skyscraper banner half page panorama
          netboard large leaderboard billboard
        ]
        classes.concat(size_modifiers)
        
        # Add positioning modifiers
        position_modifiers = @modifiers & %w[centered test]
        classes.concat(position_modifiers)
        
        classes << 'advertisement'
        classes.join(' ')
      end
    end
  end
end