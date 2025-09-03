# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for breadcrumb UI elements
    class BreadcrumbElement < BaseElement
      
      def render
        breadcrumb_items = extract_breadcrumb_items
        
        build_breadcrumb_html(breadcrumb_items)
      end
      
      private
      
      def extract_breadcrumb_items
        case @content
        when Array
          @content.map(&:to_s).map(&:strip).reject(&:empty?)
        when String
          if @content.include?('>')
            @content.split('>').map(&:strip).reject(&:empty?)
          elsif @content.include?('/')
            @content.split('/').map(&:strip).reject(&:empty?)
          elsif @content.include?('|')
            @content.split('|').map(&:strip).reject(&:empty?)
          else
            [@content.strip].reject(&:empty?)
          end
        else
          []
        end
      end
      
      def build_breadcrumb_html(items)
        return %[<div class="#{css_class}"#{html_attributes}></div>] if items.empty?
        
        sections_html = []
        
        items.each_with_index do |item, index|
          is_last = index == items.length - 1
          
          if item.include?(':') && item.match?(/^https?:/)
            # Link format: "Label:URL"
            parts = item.split(':', 2)
            label = parts[0].strip
            url = parts[1].strip
            sections_html << %[  <a class="section" href="#{escape_html(url)}">#{escape_html(label)}</a>]
          else
            # Regular section
            class_name = is_last ? "active section" : "section"
            sections_html << %[  <div class="#{class_name}">#{escape_html(item)}</div>]
          end
          
          # Add divider (except for last item)
          unless is_last
            divider_icon = has_modifier?('slash') ? 'right angle' : 'right angle'
            sections_html << %[  <i class="#{divider_icon} icon divider"></i>]
          end
        end
        
        %[<div class="#{css_class}"#{html_attributes}>
#{sections_html.join("\n")}
</div>]
      end
      
      def element_name
        'breadcrumb'
      end
      
      def css_class
        classes = ['ui']
        
        # Add size modifiers
        size_modifiers = @modifiers & %w[mini tiny small medium large big huge massive]
        classes.concat(size_modifiers)
        
        # Add divider modifiers (handled in build logic)
        # @modifiers & %w[slash] # Reserved for future use
        
        classes << 'breadcrumb'
        classes.join(' ')
      end
    end
  end
end