# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for dropdown UI elements
    class DropdownElement < BaseElement
      
      def render
        placeholder = extract_placeholder
        options = extract_options
        
        build_dropdown_html(placeholder, options)
      end
      
      private
      
      def extract_placeholder
        case @content
        when Array
          @content.first.to_s.strip
        when String
          if @content.include?('|')
            @content.split('|').first.to_s.strip
          else
            @content.strip
          end
        else
          ''
        end
      end
      
      def extract_options
        case @content
        when Array
          # Skip first item (placeholder), rest are options
          if @content.length > 1
            options = @content[1..-1].map(&:to_s).map(&:strip).reject(&:empty?)
            # Split comma-separated options
            options.flat_map { |opt| opt.include?(',') ? opt.split(',').map(&:strip) : [opt] }.reject(&:empty?)
          end
        when String
          if @content.include?('|')
            parts = @content.split('|')
            if parts.length > 1
              # Second part might contain comma-separated options
              options_str = parts[1..-1].join('|')
              if options_str.include?(',')
                options_str.split(',').map(&:strip).reject(&:empty?)
              else
                [options_str.strip].reject(&:empty?)
              end
            end
          end
        end || []
      end
      
      def build_dropdown_html(placeholder, options)
        dropdown_html = []
        
        dropdown_html << %[<div class="#{css_class}"#{html_attributes}>]
        
        # Add default text (placeholder)
        unless placeholder.empty?
          dropdown_html << %[  <div class="default text">#{escape_html(placeholder)}</div>]
        end
        
        # Add dropdown icon
        dropdown_html << %[  <i class="dropdown icon"></i>]
        
        # Add menu with options
        if options.any?
          dropdown_html << %[  <div class="menu">]
          
          options.each do |option|
            if option.include?(':')
              # Format: "value:display text"
              parts = option.split(':', 2)
              value = parts[0].strip
              display = parts[1].strip
              dropdown_html << %[    <div class="item" data-value="#{escape_html(value)}">#{escape_html(display)}</div>]
            else
              # Simple option
              dropdown_html << %[    <div class="item">#{escape_html(option)}</div>]
            end
          end
          
          dropdown_html << %[  </div>]
        end
        
        dropdown_html << %[</div>]

        # Join with newlines and add trailing newline
        result = dropdown_html.join("\n")
        result + "\n"
      end
      
      def element_name
        'dropdown'
      end
      
      def css_class
        classes = ['ui']

        # Add type modifiers
        type_modifiers = @modifiers & %w[selection search button floating labeled icon multiple]
        classes.concat(type_modifiers)
        
        # Add state modifiers
        state_modifiers = @modifiers & %w[loading error disabled active]
        classes.concat(state_modifiers)
        
        # Add appearance modifiers
        appearance_modifiers = @modifiers & %w[fluid compact pointing upward]
        classes.concat(appearance_modifiers)
        
        # Add size modifiers
        size_modifiers = @modifiers & %w[mini tiny small medium large big huge massive]
        classes.concat(size_modifiers)
        
        classes << 'dropdown'
        classes.join(' ')
      end
    end
  end
end