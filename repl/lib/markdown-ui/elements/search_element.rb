# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for search UI elements
    class SearchElement < BaseElement
      
      def render
        placeholder, search_results = extract_search_content
        
        build_search_html(placeholder, search_results)
      end
      
      private
      
      def extract_search_content
        case @content
        when Array
          placeholder = @content[0].to_s.strip
          results = @content[1..-1] if @content.length > 1
          [placeholder, results || []]
        when String
          if @content.include?('|')
            parts = @content.split('|')
            placeholder = parts[0].strip
            results = parts[1..-1] || []
            [placeholder, results]
          else
            [@content.strip, []]
          end
        else
          ['Search...', []]
        end
      end
      
      def build_search_html(placeholder, search_results)
        search_html = []
        
        search_html << %[<div class="#{css_class}"#{html_attributes}>]
        
        # Search input
        search_html << %[  <div class="ui input">]
        search_html << %[    <input type="text" placeholder="#{escape_html(placeholder)}" />]
        search_html << %[  </div>]
        
        # Search results (if provided)
        if search_results.any?
          search_html << %[  <div class="results">]
          
          search_results.each do |result|
            search_html << %[    <div class="result">]
            search_html << %[      <div class="content">]
            search_html << %[        <div class="title">#{escape_html(result)}</div>]
            search_html << %[      </div>]
            search_html << %[    </div>]
          end
          
          search_html << %[  </div>]
        end
        
        search_html << %[</div>]
        
        search_html.join("\n")
      end
      
      def element_name
        'search'
      end
      
      def css_class
        classes = ['ui']
        
        # Add type modifiers
        type_modifiers = @modifiers & %w[category selection]
        classes.concat(type_modifiers)
        
        # Add state modifiers
        state_modifiers = @modifiers & %w[loading focus]
        classes.concat(state_modifiers)
        
        # Add appearance modifiers
        appearance_modifiers = @modifiers & %w[fluid]
        classes.concat(appearance_modifiers)
        
        # Add size modifiers
        size_modifiers = @modifiers & %w[mini tiny small medium large big huge massive]
        classes.concat(size_modifiers)
        
        classes << 'search'
        classes.join(' ')
      end
    end
  end
end