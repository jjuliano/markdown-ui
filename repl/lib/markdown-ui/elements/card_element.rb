# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    class CardElement < BaseElement
      def render
        # Check if image modifier is present
        has_image_modifier = @modifiers.include?('image')

        header, meta, description, image = extract_card_parts

        return '' if header.empty? && image.nil? && !has_image_modifier

        build_card_html(header, meta, description, image || has_image_modifier)
      end
      
      private
      
      def extract_card_parts
        # Get the content as a string
        content_str = case @content
                      when Array
                        @content.join("\n")
                      when String
                        @content
                      else
                        ''
                      end

        # Convert escaped newlines to actual newlines
        content_str = content_str.gsub(/\\n/, "\n")

        if content_str.include?('|')
          # Handle pipe-separated content
          parts = content_str.split('|').map(&:strip)
          header_part = parts[0] || ''

          # Parse header part for Header:, Meta:, Description: format
          if header_part.include?(',')
            header = ''
            meta = ''
            description = ''

            # Split by comma and parse each part
            header_part.split(',').each do |part|
              part = part.strip
              if part.start_with?('Header:')
                header = part.sub(/^Header:/, '').strip
              elsif part.start_with?('Meta:')
                meta = part.sub(/^Meta:/, '').strip
              elsif part.start_with?('Description:')
                description = part.sub(/^Description:/, '').strip
              end
            end

            [header, meta, description]
          else
            [header_part, parts[1] || '', parts[2] || '']
          end
        elsif content_str.include?(',')
          # Handle comma-separated content without pipes
          header = ''
          meta = ''
          description = ''

          # Split by comma and parse each part
          content_str.split(',').each do |part|
            part = part.strip
            if part.start_with?('Header:')
              header = part.sub(/^Header:/, '').strip
            elsif part.start_with?('Meta:')
              meta = part.sub(/^Meta:/, '').strip
            elsif part.start_with?('Description:')
              description = part.sub(/^Description:/, '').strip
            end
          end

          [header, meta, description]
        else
          # Handle blockquote content - split by newlines
          lines = content_str.split("\n").map(&:strip).reject(&:empty?)

          # Check if first line is an image
          image_line = nil
          if lines[0] =~ /^!\[([^\]]*)\]\(([^)]+)\)$/
            image_line = lines[0]
            lines = lines[1..-1] # Remove image line from content
          end

          header = lines[0] || ''
          if lines.length == 1
            # Only header
            meta = ''
            description = ''
          elsif lines.length == 2
            # For image cards, 2 lines = header + meta
            # For regular cards, 2 lines = header + description
            if image_line
              meta = lines[1] || ''
              description = ''
            else
              meta = ''
              description = lines[1] || ''
            end
          else
            # Header, meta, and description
            meta = lines[1] || ''
            description = lines[2..-1]&.join(' ') || ''
          end

          [header, meta, description, image_line]
        end
      end
      
      def build_card_html(header, meta, description, image = nil)
        card_html = []

        card_html << %[<div class="#{css_class}"#{html_attributes}>]

        # Add image section if present
        if image
          if image.is_a?(String)
            # Image markdown provided in content
            alt_text, src = parse_image_markdown(image)
            card_html << %[  <div class="image">]
            card_html << %[    <img src="#{src}" alt="#{alt_text}" />]
            card_html << %[  </div>]
          elsif image == true
            # Image modifier present but no image markdown - look for image in content
            content_str = @content.is_a?(Array) ? @content.join("\n") : @content.to_s
            if content_str =~ /!\[([^\]]*)\]\(([^)]+)\)/
              alt_text, src = parse_image_markdown($&)
              card_html << %[  <div class="image">]
              card_html << %[    <img src="#{src}" alt="#{alt_text}" />]
              card_html << %[  </div>]
            end
          end
        end

        # Add content section
        card_html << %[  <div class="content">]
        unless header.empty?
          # Strip markdown formatting from header
          clean_header = header.gsub(/\*\*(.*?)\*\*/, '\1')
          card_html << %[    <div class="header">#{escape_html(clean_header)}</div>]
        end

        unless meta.empty?
          card_html << %[    <div class="meta">#{escape_html(meta)}</div>]
        end

        unless description.empty?
          card_html << %[    <div class="description">]
          card_html << %[      <p>#{escape_html(description)}</p>]
          card_html << %[    </div>]
        end

        card_html << %[  </div>]
        card_html << %[</div>]

        card_html.join("\n") + "\n"
      end
      
      def parse_image_markdown(image_markdown)
        # Parse ![alt](src) format
        if image_markdown =~ /^!\[([^\]]*)\]\(([^)]+)\)$/
          alt_text = $1
          src = $2
          [alt_text, src]
        else
          ['', '']
        end
      end

      def parse_markdown(text)
        return '' if text.nil? || text.empty?

        # Simple markdown parsing for bold text
        text.gsub(/\*\*(.*?)\*\*/, '<strong>\1</strong>')
      end

      def css_class
        # Filter out modifiers that are handled specially (like 'image')
        special_modifiers = ['image']
        filtered_modifiers = @modifiers.reject { |mod| special_modifiers.include?(mod) }

        classes = ['ui']
        classes.concat(filtered_modifiers) if filtered_modifiers.any?
        classes << element_name

        # Merge with any CSS classes from attributes
        if @attributes && @attributes['class']
          custom_classes = Array(@attributes['class'])
          classes.concat(custom_classes)
        end

        classes.join(' ')
      end

      def element_name
        'card'
      end
    end
  end
end