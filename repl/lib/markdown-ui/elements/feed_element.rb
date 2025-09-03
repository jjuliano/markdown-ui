# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for feed UI elements (activity feeds)
    class FeedElement < BaseElement
      
      def render
        feed_items = extract_feed_items
        
        build_feed_html(feed_items)
      end
      
      private
      
      def extract_feed_items
        case @content
        when Array
          @content.map(&:to_s).map(&:strip).reject(&:empty?)
        when String
          if @content.include?('|')
            @content.split('|').map(&:strip).reject(&:empty?)
          else
            [@content.strip].reject(&:empty?)
          end
        else
          []
        end
      end
      
      def build_feed_html(feed_items)
        feed_html = []
        
        feed_html << %[<div class="#{css_class}"#{html_attributes}>]
        
        if feed_items.any?
          feed_items.each do |item|
            feed_html << %[  <div class="event">]
            
            # Label (icon or image)
            feed_html << %[    <div class="label">]
            feed_html << %[      <img src="/avatar/default.jpg" alt="User" />]
            feed_html << %[    </div>]
            
            # Content
            feed_html << %[    <div class="content">]
            feed_html << %[      <div class="summary">]
            feed_html << %[        #{escape_html(item)}]
            feed_html << %[        <div class="date">Just now</div>]
            feed_html << %[      </div>]
            feed_html << %[    </div>]
            
            feed_html << %[  </div>]
          end
        else
          # Default feed item
          feed_html << %[  <div class="event">]
          feed_html << %[    <div class="label">]
          feed_html << %[      <img src="/avatar/default.jpg" alt="User" />]
          feed_html << %[    </div>]
          feed_html << %[    <div class="content">]
          feed_html << %[      <div class="summary">]
          feed_html << %[        Sample feed activity]
          feed_html << %[        <div class="date">Just now</div>]
          feed_html << %[      </div>]
          feed_html << %[    </div>]
          feed_html << %[  </div>]
        end
        
        feed_html << %[</div>]
        
        feed_html.join("\n")
      end
      
      def element_name
        'feed'
      end
      
      def css_class
        classes = ['ui']
        
        # Add size modifiers
        size_modifiers = @modifiers & %w[small large]
        classes.concat(size_modifiers)
        
        classes << 'feed'
        classes.join(' ')
      end
    end
  end
end