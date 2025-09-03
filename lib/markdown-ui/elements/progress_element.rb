# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for progress UI elements
    class ProgressElement < BaseElement
      
      def render
        label = extract_label
        percentage = extract_percentage

        # Return empty if we have no label and no percentage (no meaningful content)
        return '' if label.empty? && percentage == 0

        build_progress_html(label, percentage)
      end
      
      private
      
      def extract_label
        case @content
        when Array
          return '' if @content.empty?
          first_part = @content.first.to_s.strip
          # If first part looks like a number (percentage), treat it as percentage, no label
          return '' if first_part.match?(/^\d+%?$/)
          first_part
        when String
          if @content.include?('|')
            parts = @content.split('|')
            first_part = parts.first.to_s.strip
            # If first part looks like a number (percentage), treat it as percentage, no label
            return '' if first_part.match?(/^\d+%?$/)
            first_part
          else
            @content.strip
          end
        else
          ''
        end
      end

      def extract_percentage
        case @content
        when Array
          return 0 if @content.empty?
          first_part = @content.first.to_s.strip
          # If first part is a number, use it as percentage
          if first_part.match?(/^\d+%?$/)
            return parse_percentage(first_part)
          end
          # Otherwise, second part should be percentage
          percentage_str = @content[1].to_s.strip if @content.length > 1
          parse_percentage(percentage_str)
        when String
          if @content.include?('|')
            parts = @content.split('|')
            first_part = parts.first.to_s.strip

            # If first part is a number, use it as percentage
            if first_part.match?(/^\d+%?$/)
              return parse_percentage(first_part)
            end

            # Otherwise, second part should be percentage
            percentage_str = parts[1].to_s.strip if parts.length > 1
            parse_percentage(percentage_str)
          else
            # If content is just a number, treat it as percentage
            if @content.strip.match?(/^\d+%?$/)
              parse_percentage(@content.strip)
            else
              0
            end
          end
        else
          0
        end
      end
      
      def parse_percentage(percentage_str)
        return 0 if percentage_str.nil? || percentage_str.empty?
        
        # Remove % symbol if present and convert to integer
        cleaned = percentage_str.gsub('%', '').strip
        value = cleaned.to_i
        
        # Clamp between 0 and 100
        [[value, 0].max, 100].min
      end
      
      def build_progress_html(label, percentage)
        progress_html = []

        # Add data-percent attribute to the main div
        data_percent_attr = percentage > 0 ? %( data-percent="#{percentage}") : ''
        progress_html << %[<div class="#{css_class}"#{data_percent_attr}#{html_attributes}>]

        # Determine bar content based on modifiers and whether there's a label
        if has_modifier?('disabled')
          # For disabled progress, just the bar without progress div
          progress_html << %[  <div class="bar" style="width: #{percentage}%"></div>]
          # Add label if present
          if !label.empty?
            progress_html << %[  <div class="label">#{escape_html(label)}</div>]
          end
        elsif has_modifier?('attached')
          # For attached progress, just the bar (no progress div or label)
          progress_html << %[  <div class="bar" style="width: #{percentage}%"></div>]
        elsif has_size_modifier? || label.empty?
          # For size modifiers (tiny, small, medium, large, big) or no label, bar without progress div
          progress_html << %[  <div class="bar" style="width: #{percentage}%"></div>]
          # Add label if present
          if !label.empty?
            progress_html << %[  <div class="label">#{escape_html(label)}</div>]
          end
        else
          # Default case: bar with progress div and label
          progress_html << %[  <div class="bar" style="width: #{percentage}%">]
          progress_html << %[    <div class="progress">#{percentage}%</div>]
          progress_html << %[  </div>]
          if !label.empty?
            progress_html << %[  <div class="label">#{escape_html(label)}</div>]
          end
        end

        progress_html << %[</div>]

        progress_html.join("\n") + "\n"
      end

      def has_size_modifier?
        size_modifiers = %w[tiny small medium large big huge massive]
        @modifiers.any? { |mod| size_modifiers.include?(mod) }
      end
      
      def element_name
        'progress'
      end
      
      def css_class
        classes = ['ui']
        
        # Add state modifiers
        state_modifiers = @modifiers & %w[indicating active success warning error disabled]
        classes.concat(state_modifiers)
        
        # Add color modifiers
        color_modifiers = @modifiers & %w[red orange yellow olive green teal blue violet purple pink brown grey black]
        classes.concat(color_modifiers)
        
        # Add size modifiers
        size_modifiers = @modifiers & %w[tiny small medium large big huge massive]
        classes.concat(size_modifiers)
        
        # Add appearance modifiers
        appearance_modifiers = @modifiers & %w[inverted attached]
        classes.concat(appearance_modifiers)
        
        classes << 'progress'
        classes.join(' ')
      end
    end
  end
end