# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for statistic UI elements (numerical displays)
    class StatisticElement < BaseElement
      
      def render
        stat_value, stat_label = extract_statistic_content
        
        build_statistic_html(stat_value, stat_label)
      end
      
      private
      
      def extract_statistic_content
        case @content
        when Array
          value = @content[0].to_s.strip
          label = @content[1].to_s.strip if @content.length > 1
          [value, label || '']
        when String
          if @content.include?('|')
            parts = @content.split('|', 2)
            [parts[0].strip, parts[1].strip]
          else
            [@content.strip, '']
          end
        else
          ['0', '']
        end
      end
      
      def build_statistic_html(stat_value, stat_label)
        stat_html = []
        
        stat_html << %[<div class="#{css_class}"#{html_attributes}>]
        
        # Value
        stat_html << %[  <div class="value">#{escape_html(stat_value)}</div>]
        
        # Label
        unless stat_label.empty?
          stat_html << %[  <div class="label">#{escape_html(stat_label)}</div>]
        end
        
        stat_html << %[</div>]
        
        stat_html.join("\n")
      end
      
      def element_name
        'statistic'
      end
      
      def css_class
        classes = ['ui']
        
        # Add color modifiers
        color_modifiers = @modifiers & %w[
          red orange yellow olive green teal blue violet purple pink brown grey black
        ]
        classes.concat(color_modifiers)
        
        # Add size modifiers
        size_modifiers = @modifiers & %w[mini tiny small medium large big huge massive]
        classes.concat(size_modifiers)
        
        # Add appearance modifiers
        appearance_modifiers = @modifiers & %w[inverted horizontal]
        classes.concat(appearance_modifiers)
        
        classes << 'statistic'
        classes.join(' ')
      end
    end
  end
end