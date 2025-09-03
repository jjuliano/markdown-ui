# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for tab UI elements
    class TabElement < BaseElement
      
      def render
        tabs = extract_tabs
        
        build_tab_html(tabs)
      end
      
      private
      
      def extract_tabs
        # Expected format: ["Tab 1:Content 1", "Tab 2:Content 2", ...]
        case @content
        when Array
          @content.map.with_index { |tab, index| parse_tab(tab.to_s, index) }.compact
        when String
          [@content].map.with_index { |tab, index| parse_tab(tab, index) }.compact
        else
          []
        end
      end
      
      def parse_tab(tab_str, index)
        return nil if tab_str.nil? || tab_str.strip.empty?
        
        if tab_str.include?(':')
          parts = tab_str.split(':', 2)
          tab_id = generate_tab_id(parts[0].strip, index)
          {
            id: tab_id,
            title: parts[0].strip,
            content: parts[1].strip,
            active: index == 0 # First tab is active by default
          }
        else
          # If no colon, treat as title only
          tab_id = generate_tab_id(tab_str.strip, index)
          {
            id: tab_id,
            title: tab_str.strip,
            content: '',
            active: index == 0
          }
        end
      end
      
      def generate_tab_id(title, index)
        # Generate a valid HTML ID from title
        base_id = title.downcase.gsub(/\W/, '').gsub(/\s+/, '')
        base_id.empty? ? "tab#{index}" : base_id
      end
      
      def build_tab_html(tabs)
        return %[<div class="#{css_class}"#{html_attributes}></div>] if tabs.empty?
        
        tab_html = []
        
        # Tab menu navigation
        tab_html << %[<div class="ui #{menu_class} menu">]
        
        tabs.each do |tab|
          item_class = tab[:active] ? 'active item' : 'item'
          tab_html << %[  <div class="#{item_class}" data-tab="#{tab[:id]}">#{escape_html(tab[:title])}</div>]
        end
        
        tab_html << %[</div>]
        
        # Tab content panes
        tabs.each do |tab|
          pane_class = tab[:active] ? 'ui active tab segment' : 'ui tab segment'
          tab_html << %[<div class="#{pane_class}" data-tab="#{tab[:id]}">]
          
          if tab[:content].empty?
            tab_html << %[  <p></p>]
          else
            # Process content
            content_lines = tab[:content].split("\n").map(&:strip).reject(&:empty?)
            if content_lines.length == 1
              tab_html << %[  <p>#{escape_html(content_lines.first)}</p>]
            else
              content_lines.each do |line|
                tab_html << %[  <p>#{escape_html(line)}</p>]
              end
            end
          end
          
          tab_html << %[</div>]
        end
        
        tab_html.join("\n")
      end
      
      def menu_class
        # Tab menu can have different styles
        menu_modifiers = @modifiers & %w[secondary pointing tabular text]
        menu_modifiers.any? ? menu_modifiers.join(' ') : 'tabular'
      end
      
      def element_name
        'tab'
      end
      
      def css_class
        classes = []
        
        # Tabs don't typically have UI classes on the container
        # The styling comes from the menu and segments
        
        classes << 'tabs' if classes.empty?
        classes.join(' ')
      end
    end
  end
end