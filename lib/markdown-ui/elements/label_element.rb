# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for label UI elements
    class LabelElement < BaseElement
      
      def render
        label_text = extract_label_text
        icon_name = extract_icon
        detail = extract_detail
        image_url = extract_image

        build_label_html(label_text, icon_name, detail, image_url)
      end
      
      private
      
      def extract_label_text
        case @content
        when Array
          # Find the main text (not icon, detail, or image)
          text_item = @content.find { |item| !item.to_s.match?(/^(icon[:\s]|detail[:\s]|image[:\s])/i) && !item.to_s.match?(/^image /i) }
          text_item.to_s.strip if text_item
        when String
          if @content.include?('|')
            @content.split('|').first.to_s.strip
          else
            @content.strip
          end
        else
          ''
        end || ''
      end
      
      def extract_icon
        case @content
        when Array
          icon_item = @content.find { |item| item.to_s.match?(/^icon[:\s]/i) }
          icon_item.sub(/^icon[:\s]/i, '').strip if icon_item
        when String
          if @content.match?(/icon:/i)
            @content.sub(/.*icon:/i, '').split('|').first.to_s.strip
          end
        end
      end
      
      def extract_detail
        case @content
        when Array
          detail_item = @content.find { |item| item.to_s.match?(/^detail[:\s]/i) }
          detail_item.sub(/^detail[:\s]/i, '').strip if detail_item
        when String
          if @content.match?(/detail:/i)
            @content.sub(/.*detail:/i, '').strip
          elsif @content.include?('|') && @content.split('|').length > 1
            @content.split('|')[1].to_s.strip
          end
        end
      end

      def extract_image
        case @content
        when Array
          image_item = @content.find { |item| item.to_s.match?(/^image[:\s]/i) }
          if image_item
            image_item.sub(/^image[:\s]/i, '').strip
          end
        when String
          if @content.match?(/image:/i)
            @content.sub(/.*image:/i, '').strip
          end
        end
      end
      
      def build_label_html(label_text, icon_name, detail, image_url)
        content_html = []

        # Add image if specified (comes first)
        if image_url && !image_url.empty?
          content_html << %[<img src="#{escape_html(image_url)}" />]
        end

        # Add icon if specified, or generic icon for corner labels
        if has_modifier?('corner')
          content_html << %[  <i class="icon"></i>]
        elsif icon_name && !icon_name.empty?
          content_html << %[<i class="#{icon_name.downcase.gsub(' ', ' ')} icon"></i>]
        end

        # Add main text (skip for corner labels)
        unless has_modifier?('corner')
          content_html << escape_html(label_text) unless label_text.empty?
        end

        # Add detail if specified
        if detail && !detail.empty?
          content_html << %[<div class="detail">#{escape_html(detail)}</div>]
        end

        tag_name = determine_tag_name
        image_url = extract_image
        has_image = image_url && !image_url.empty?

        if content_html.empty?
          %[<#{tag_name} class="#{css_class}"#{html_attributes}></#{tag_name}>]
        elsif content_html.length == 1 && !has_modifier?('corner') && !has_image
          # Single content element - inline (except for corner labels and image labels)
          content = content_html.join
          %[<#{tag_name} class="#{css_class}"#{html_attributes}>#{content}</#{tag_name}>]
        else
          # Multiple content elements, corner labels, or image labels
          if has_image && content_html.length == 2
            # Special case for image + text: inline image, separate text
            content = content_html.join("\n  ")
            %[<#{tag_name} class="#{css_class}"#{html_attributes}>#{content}
</#{tag_name}>]
          elsif content_html.length == 2 && content_html.any? { |item| item.include?('<i class=') }
            # Special case for icon + text: inline icon, separate text
            icon_part = content_html.find { |item| item.include?('<i class=') }
            text_part = content_html.find { |item| !item.include?('<i class=') }
            %[<#{tag_name} class="#{css_class}"#{html_attributes}>#{icon_part}
  #{text_part}
</#{tag_name}>]
          elsif content_html.length == 2 && content_html.any? { |item| item.include?('<div class="detail">') }
            # Special case for text + detail: text on first line, detail indented
            text_part = content_html.find { |item| !item.include?('<div class="detail">') }
            detail_part = content_html.find { |item| item.include?('<div class="detail">') }
            %[<#{tag_name} class="#{css_class}"#{html_attributes}>#{text_part}
  #{detail_part}
</#{tag_name}>]
          else
            # General multiline case
            content = content_html.join
            %[<#{tag_name} class="#{css_class}"#{html_attributes}>
#{content}
</#{tag_name}>]
          end
        end
      end
      
      def determine_tag_name
        # Labels can be div, a, or span depending on context
        if has_modifier?('link') || get_attribute(:href)
          'a'
        elsif has_modifier?('tag')
          'div'
        else
          'div'
        end
      end
      
      def element_name
        'label'
      end
      
      def css_class
        classes = ['ui']

        # Add type modifiers (split compound modifiers first)
        all_modifiers = @modifiers.flat_map { |mod| mod.split }
        type_modifiers = all_modifiers & %w[basic pointing corner tag ribbon attached floating circular]
        classes.concat(type_modifiers)

        # Add image modifier if image is present
        image_url = extract_image
        classes << 'image' if image_url && !image_url.empty?

        # Add color modifiers (split compound modifiers first)
        all_modifiers = @modifiers.flat_map { |mod| mod.split }
        color_modifiers = all_modifiers & %w[red orange yellow olive green teal blue violet purple pink brown grey black]
        classes.concat(color_modifiers)

        # Add size modifiers
        size_modifiers = @modifiers & %w[mini tiny small medium large big huge massive]
        classes.concat(size_modifiers)

        # Add position modifiers for pointing/corner labels
        position_modifiers = @modifiers & %w[left right above below top bottom]
        classes.concat(position_modifiers)

        classes << 'label'

        # Merge with any CSS classes from attributes
        if @attributes && @attributes['class']
          custom_classes = Array(@attributes['class'])
          classes.concat(custom_classes)
        end

        classes.join(' ')
      end
    end
  end
end