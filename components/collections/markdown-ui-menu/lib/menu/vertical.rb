# coding: UTF-8

module MarkdownUI
  module Menu
    class Vertical < MarkdownUI::Shared::TagKlass
      def initialize(_content, _klass = nil)
        @_klass  = _klass
        @content = _content
      end

      def render
        @klass = "ui #{@_klass} vertical menu"
        parsed_content = parse_menu_content(@content)

        MarkdownUI::StandardTag.new(parsed_content, klass_text).render
      end

      private

      def parse_menu_content(content)
        return content if content.nil? || content.empty?


        lines = content.lines.map(&:strip).reject(&:empty?)

        menu_items = []
        i = 0
        while i < lines.length
          line = lines[i]

          if line =~ /^\[([^\]]+)\]\(([^)]+)\)$/  # Markdown link format
            link_text = $1
            link_url = $2

            # Parse inline components in link text (e.g., __Div Tag|content|modifiers__)
            parsed_link_text = parse_inline_components(link_text)

            # Parse title/attributes if present
            if link_url.include?(' "')
              url_parts = link_url.split(' "')
              href = url_parts[0]
              title_attr = url_parts[1].gsub('"', '').strip

              # Check for special classes
              classes = ['ui', 'item']
              classes << 'active' if title_attr.include?('active')
              classes << 'teal' if title_attr.include?('teal')
              classes << 'pointing' if title_attr.include?('pointing')
              classes << 'left' if title_attr.include?('left')

              # Handle special cases like labels
              if title_attr.include?('label')
                label_class = title_attr.split.find { |part| part.include?('label') }
                if label_class
                  label_parts = label_class.split(' ')
                  if label_parts.length > 1
                    classes << "#{label_parts[1]} pointing #{label_parts[0]}"
                  end
                end
              end

              class_attr = classes.uniq.join(' ')
              menu_items << "<a class=\"#{class_attr}\" href=\"#{href}\">#{parsed_link_text}</a>"
            else
              menu_items << "<a class=\"ui item\" href=\"#{link_url}\">#{parsed_link_text}</a>"
            end
            i += 1
          elsif line =~ /^!\[([^\]]*)\]\(([^)]+)\)$/  # Image
            alt_text = $1
            image_url = $2
            menu_items << "<img src=\"#{image_url}\" alt=\"#{alt_text}\" />"
            i += 1
          else
            # Regular content line
            menu_items << line
            i += 1
          end
        end

        menu_items.join("")
      end

      def parse_inline_components(text)
        return text if text.nil? || text.empty?


        # Handle inline components like __Div Tag|content|modifiers__
        text.gsub(/__([^|]+)\|([^|]+)\|(.+?)__/m) do |match|
          element = $1.strip
          content = $2.strip
          modifiers = $3.strip

          # Parse the modifiers and create appropriate HTML
          if element.downcase.include?('div') || element.downcase.include?('tag')
            # Handle div tag with modifiers
            classes = []
            modifiers.split.each do |modifier|
              case modifier.downcase
              when 'label'
                classes << 'label'
              when 'teal'
                classes << 'teal'
              when 'pointing'
                classes << 'pointing'
              when 'left'
                classes << 'left'
              when 'right'
                classes << 'right'
              end
            end

            class_attr = classes.empty? ? '' : " class=\"#{classes.join(' ')}\""
            "<div#{class_attr}>#{content}</div>"
          else
            # For other components, just return the original text
            match
          end
        end
      end
    end
  end
end
