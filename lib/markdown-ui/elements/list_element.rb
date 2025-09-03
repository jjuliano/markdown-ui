# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for list UI elements
    class ListElement < BaseElement
      
      def render
        list_items = extract_list_items
        
        build_list_html(list_items)
      end
      
      private
      
      def extract_list_items
        case @content
        when Array
          @content.map(&:to_s).map(&:strip).reject(&:empty?)
        when String
          # Support various separators
          if @content.include?('|')
            @content.split('|').map(&:strip).reject(&:empty?)
          elsif @content.include?(',')
            @content.split(',').map(&:strip).reject(&:empty?)
          elsif @content.include?("\n")
            @content.split("\n").map(&:strip).reject(&:empty?)
          else
            [@content.strip].reject(&:empty?)
          end
        else
          []
        end
      end
      
      def build_list_html(list_items)
        return %[<div class="#{css_class}"#{html_attributes}></div>] if list_items.empty?
        
        items_html = list_items.map do |item|
          if item.match?(/Icon:/i) || item.match?(/Image:/i)
            # Complex list item with icon/image
            build_complex_item(item)
          else
            # Simple list item
            %[  <div class="item">#{escape_html(item)}</div>]
          end
        end
        
        %[<div class="#{css_class}"#{html_attributes}>
#{items_html.join("\n")}
</div>]
      end
      
      def build_complex_item(item)
        parts = item.split('|')
        content_html = []
        
        parts.each do |part|
          part = part.strip
          if part.match?(/^Icon:/i)
            icon_name = part.sub(/^Icon:/i, '').strip
            content_html << %[<i class="#{icon_name.downcase.gsub(' ', ' ')} icon"></i>]
          elsif part.match?(/^Image:/i)
            image_src = part.sub(/^Image:/i, '').strip
            content_html << %[<img class="ui avatar image" src="#{escape_html(image_src)}" />]
          else
            # Regular content
            content_html << %[<div class="content">#{escape_html(part)}</div>] unless part.empty?
          end
        end
        
        %[  <div class="item">#{content_html.join}</div>]
      end
      
      def element_name
        'list'
      end
      
      def css_class
        classes = ['ui']
        
        # Add type modifiers
        type_modifiers = @modifiers & %w[bulleted numbered link selection animated relaxed divided celled ordered]
        classes.concat(type_modifiers)
        
        # Add appearance modifiers
        appearance_modifiers = @modifiers & %w[horizontal inverted]
        classes.concat(appearance_modifiers)
        
        # Add size modifiers
        size_modifiers = @modifiers & %w[mini tiny small medium large big huge massive]
        classes.concat(size_modifiers)
        
        classes << 'list'
        classes.join(' ')
      end
    end
  end
end