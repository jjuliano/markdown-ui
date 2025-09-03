# coding: UTF-8

module MarkdownUI
  module Button
    class Animated
      def initialize(content, klass = nil, _id = nil)
        @content                          = content
        @klass                            = klass
        @id                               = _id
        if content.is_a?(Array)
          # Handle array format where each element might be "Text:value:Content"
          if content.all? { |item| item.include?('Text:') && item.include?(':') }
            # Parse complex format from array elements
            @visible_content = ''
            @hidden_content = ''
            content.each do |item|
              if item.strip =~ /Text:(.+?):Visible Content/i
                @visible_content = $1.strip
              elsif item.strip =~ /Text:(.+?):Hidden Content/i
                @hidden_content = $1.strip
              end
            end
          else
            # Simple array format: [visible, hidden]
            @visible_content, @hidden_content = content
          end
        else
          # Handle complex content format: "Text:visible:Visible Content,Text:hidden:Hidden Content"
          if content.include?('Text:') && content.include?(',')
            parse_complex_content(content)
          else
            # Simple format: "visible;hidden" or "Text:visible;Icon:hidden"
            parts = content.split(';', 2)  # Split on first semicolon only
            @visible_content = extract_text_content(parts[0])
            @hidden_content = extract_icon_content(parts[1]) if parts[1]
            @hidden_content ||= ''  # Default to empty string if no hidden content
          end
        end
      end

      def parse_complex_content(content)
        # Parse format like: "Text:Sign-up for a Pro account:Visible Content,Text:$12.99 a month:Hidden Content"
        parts = content.split(',')
        @visible_content = ''
        @hidden_content = ''

        parts.each do |part|
          if part.strip =~ /Text:(.+?):Visible Content/i
            @visible_content = $1.strip
          elsif part.strip =~ /Text:(.+?):Hidden Content/i
            @hidden_content = $1.strip
          end
        end
      end

      def extract_text_content(part)
        return part unless part
        if part.strip =~ /^Text:(.+)$/i
          $1.strip
        else
          part.strip
        end
      end

      def extract_icon_content(part)
        return part unless part
        if part.strip =~ /^Icon:(.+)$/i
          # Convert icon name to HTML icon
          icon_name = $1.strip.downcase.gsub(' ', ' ')
          "<i class=\"#{icon_name} icon\"></i>"
        elsif part.strip =~ /^Text:(.+)$/i
          # Extract text content (for hidden content that is text, not icon)
          $1.strip
        else
          part.strip
        end
      end

      private :parse_complex_content, :extract_text_content, :extract_icon_content

      def render
        # Clean up klass to avoid duplication
        base_class = @klass || ""
        # Remove 'ui', 'animated' and 'button' if they're already there to avoid duplication
        clean_class = base_class.gsub(/\b(ui|animated|button)\b/, '').strip.squeeze(' ')
        klass = "ui #{clean_class} animated button".gsub(/\s+/, ' ').strip
        _id = @id

        # Handle visible and hidden content parsing
        if @content.is_a? Array
          visible_content = @visible_content
          hidden_content  = @hidden_content
        else
          # Parse content by splitting on semicolon
          visible_content = @visible_content.strip if @visible_content
          hidden_content = @hidden_content.strip if @hidden_content

          # For hidden content that contains markdown (like _Icon_), parse it through markdown
          if hidden_content && (hidden_content.include?('_') || hidden_content.include?('*'))
            # Use the markdown parser to convert markdown to HTML
            markdown_parser = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new)
            hidden_content = markdown_parser.render(hidden_content.strip)
          end
        end


        # Generate properly formatted content
        visible_div = if visible_content && visible_content.include?('<div class="visible content">')
          visible_content
        else
          "  <div class=\"visible content\">#{visible_content || ''}</div>\n"
        end

        hidden_div = if hidden_content && hidden_content.include?('<div class="hidden content">')
          hidden_content
        else
          # For hidden content, check if it needs special indentation (like icons)
          if hidden_content && hidden_content.include?('<i class=')
            "  <div class=\"hidden content\">\n    #{hidden_content}\n  </div>\n"
          else
            "  <div class=\"hidden content\">#{hidden_content || ''}</div>\n"
          end
        end

        inner_content = [visible_div, hidden_div].join("")

        # Include ID if present
        id_attr = _id ? " id=\"#{_id}\"" : ""

        result = "<div class=\"#{klass}\"#{id_attr}>\n#{inner_content}</div>\n"
        result
      end
    end
  end
end
