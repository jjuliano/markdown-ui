# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    class MessageElement < BaseElement
      def render
        header_text, body_text = parse_message_content
        
        # Determine format first
        use_compact = !should_use_indented_format(nil) # Most messages use compact
        
        content_html = build_message_html(header_text, body_text, use_compact)

        # Most messages use compact format based on test expectations
        # Only use indented format for very specific cases
        if should_use_indented_format(content_html)
          # Multi-line format for specific complex messages
          formatted_content = indent_content(content_html)
          opening_tag('div') + "\n" + formatted_content + "\n" + closing_tag('div') + "\n"
        else
          # Compact format for most messages (default)
          opening_tag('div') + content_html + closing_tag('div') + "\n"
        end
      end

      def element_name
        'message'
      end

      def css_class
        classes = ['ui']
        classes.concat(@modifiers) if @modifiers.any?
        classes << element_name

        # Merge with any CSS classes from attributes
        if @attributes && @attributes['class']
          custom_classes = Array(@attributes['class'])
          classes.concat(custom_classes)
        end

        classes.join(' ').encode('UTF-8')
      end

      private

      def should_use_indented_format(content_html)
        # Use indented format for messages with both header and body content
        # This applies to error/success/warning/info messages in forms
        header_text, body_text = parse_message_content
        has_both_parts = !header_text.nil? && !header_text.empty? && !body_text.nil? && !body_text.empty?
        has_modifier = has_modifier?('error') || has_modifier?('success') || has_modifier?('warning') || has_modifier?('info')
        has_modifier && has_both_parts
      end

      def indent_content(content)
        content.split("\n").map do |line|
          line.strip.empty? ? line : "  #{line.rstrip}"
        end.join("\n")
      end

      def parse_message_content
        content_str = @content.is_a?(Array) ? @content.join("\n") : @content.to_s
        # Handle escaped newlines
        content_str = content_str.gsub(/\\n/, "\n")


        # Handle simple array format: [header, body_text]
        if @content.is_a?(Array) && @content.length == 2
          header_text = @content[0].to_s.strip
          # Check if header contains __Header|...__ format
          if header_text.match?(/^__Header\|(.+)__/)
            # Parse the header content
            require_relative '../parser'
            parser = MarkdownUI::Parser.new
            parsed_header = parser.parse(header_text)
            header_match = parsed_header.match(/<h\d[^>]*>(.*?)<\/h\d>/)
            header = header_match ? header_match[1].strip : header_text
          else
            header = header_text
          end
          body_text = @content[1].to_s.strip
          # Handle quoted text in body
          if body_text.match?(/^"(.+)"$/)
            body_text = body_text.match(/^"(.+)"$/)[1]
          end
          raw_text_parts = [body_text]
          return [header, raw_text_parts]
        end

        # Handle double underscore format with Icon: "Header:Warning,Icon:Warning,Text:\"...\""
        if content_str.match?(/Icon:.+,Text:.+/i)
          icon_match = content_str.match(/Icon:([^,]+)/i)
          text_match = content_str.match(/Text:(?:"([^"]+)"|([^,]+))$/i)
          header_match = content_str.match(/Header:([^,]+)/i)

          header = header_match ? header_match[1].strip : nil
          icon_name = icon_match ? icon_match[1].strip.downcase : nil
          text = text_match ? (text_match[1] || text_match[2]) : content_str

          # Clean up escaped characters
          text = text.gsub(/\\!/, '!') if text

          # If we have an icon, format it properly and return as direct content
          if icon_name && text
            direct_content = "<i class=\"#{icon_name} icon\"></i>#{text}"
            # Return special format to indicate direct content (no <p> wrapping)
            return [header, {:direct => direct_content}]
          end

          return [header, [text]]
        end

        # Handle double underscore format: "Header:Changes in Service,Text:\"...\""
        if content_str.match?(/Header:.+,Text:.+/i)
          header_match = content_str.match(/Header:([^,]+),/i)
          text_match = content_str.match(/Text:(?:"([^"]+)"|([^,]+))$/i)
          header = header_match ? header_match[1].strip : nil
          text = text_match ? (text_match[1] || text_match[2]) : content_str
          return [header, [text]]
        end

        # Handle list format: "Header:..., List:..."
        if content_str.match?(/Header:.+, List:.+/i)
          header_match = content_str.match(/Header:([^,]+),/i)
          list_match = content_str.match(/List:([^,]+(;[^,]*)*)/i)
          header = header_match ? header_match[1].strip : nil
          list_items = list_match ? list_match[1].split(';').map(&:strip) : []
          return [header, list_items]
        end

        # Handle blockquote format - look for header and text
        lines = content_str.split("\n").map(&:strip)
        header = nil
        raw_text_parts = []

        lines.each do |line|
          if line.match?(/^__Header\|/)
            # Parse header from __Header|text__
            require_relative '../parser'
            parser = MarkdownUI::Parser.new
            parsed_header = parser.parse(line)
            # Extract just the header content from the parsed result
            header_match = parsed_header.match(/<h\d[^>]*>(.*?)<\/h\d>/)
            extracted = header_match ? header_match[1].strip : line
            header = extracted
          elsif line.match?(/^"(.+)"$/)
            # Extract quoted text (don't HTML encode)
            text_match = line.match(/^"(.+)"$/)
            raw_text_parts << text_match[1] if text_match
          elsif line.match?(/^_(.+)_$/) && line.downcase.include?('icon')
            # Handle _Warning Icon_ format - this should be parsed as an icon
            icon_text = line.match(/^_(.+)_$/)[1]
            if icon_text.downcase.match?(/(.+)\s+icon/i)
              icon_name = icon_text.match(/(.+)\s+icon/i)[1].strip.downcase
              raw_text_parts << "<i class=\"#{icon_name} icon\"></i>"
            else
              raw_text_parts << line
            end
          elsif line.match?(/^\d+\.\s+/)
            # Ordered list item - keep the numbering for detection
            raw_text_parts << line
          elsif line.match?(/^[-*]\s+/)
            # Unordered list item - keep the marker for detection
            raw_text_parts << line
          elsif !line.empty? && !line.match?(/^__/)
            # Regular text content - clean up escape characters
            clean_line = line.gsub(/\\!/, '!')
            raw_text_parts << clean_line
          end
        end

        # Special handling: if we have multiple text parts and some are list items,
        # treat the first non-list item as a header
        if header.nil? && raw_text_parts.length > 1
          list_items = raw_text_parts.select { |item| item.match?(/^\d+\./) || item.match?(/^[-*]\s+/) }
          non_list_items = raw_text_parts.reject { |item| item.match?(/^\d+\./) || item.match?(/^[-*]\s+/) }

          if !list_items.empty? && !non_list_items.empty?
            # Use the first non-list item as header, keep list items as content
            header = non_list_items.first
            raw_text_parts = list_items + non_list_items[1..-1]
          end
        end

        [header, raw_text_parts]
      end

      def build_message_html(header_text, body_content, compact = false)
        html_parts = []

        # Add header if present
        if header_text
          # For error and success messages, use plain "header" class instead of "ui header"
          header_class = (has_modifier?('error') || has_modifier?('success')) ? 'header' : 'ui header'
          html_parts << "<div class=\"#{header_class}\">#{escape_html(header_text)}</div>"
        end

        # Add body content
        if body_content
          # Check for direct content (icon + text format)
          if body_content.is_a?(Hash) && body_content[:direct]
            html_parts << body_content[:direct]
          elsif body_content.is_a?(Array)
            # Handle list items - check if ordered or unordered
            if body_content.any?
              # Check if this is an ordered list (contains numbered items)
              has_ordered_items = body_content.any? { |item| item.match?(/^\d+\./) }
              if has_ordered_items
                list_items = body_content.map { |item| "<li>#{escape_html(item.sub(/^\d+\.\s*/, ''))}</li>" }.join("")
                html_parts << "<ol class=\"ui ordered list\">#{list_items}</ol>"
              else
                # Check if unordered list (contains - or * markers)
                has_unordered_items = body_content.any? { |item| item.match?(/^[-*]\s+/) }
                if has_unordered_items
                  list_items = body_content.map { |item| "<li>#{escape_html(item.sub(/^[-*]\s*/, ''))}</li>" }.join("")
                  html_parts << "<ul class=\"ui unordered list\">#{list_items}</ul>"
                else
                  # Check if this contains icon HTML (from blockquote format)
                  has_icon_html = body_content.any? { |item| item.include?('<i class="') }
                  
                  if has_icon_html
                    # For blockquote format with icon, join with newlines and don't wrap in tags
                    content_with_newlines = body_content.join("\n")
                    html_parts << content_with_newlines
                  elsif body_content.length > 1 && body_content.all? { |item| !item.match?(/^\d+\./) && !item.match?(/^[-*]\s+/) }
                    # Check if this is a parsed list from message content (not markdown markers)
                    list_items = body_content.map { |item| "<li>#{escape_html(item)}</li>" }.join("")
                    html_parts << "<ul class=\"ui list\">#{list_items}</ul>"
                  else
                    # Regular text content - don't escape if it came from quotes
                    text_content = body_content.join(" ")
                    # Check if this came from quoted text (no HTML entities)
                    if text_content.include?('&') || text_content.match?(/__.*__/)
                      html_parts << "<p>#{escape_html(text_content)}</p>"
                    else
                      html_parts << "<p>#{text_content}</p>"
                    end
                  end
                end
              end
            end
          elsif !body_content.strip.empty?
            html_parts << "<p>#{escape_html(body_content)}</p>"
          end
        end

        # Return HTML - compact format joins without newlines, indented format uses newlines
        if compact
          html_parts.reject(&:empty?).join("")
        else
          html_parts.reject(&:empty?).join("\n")
        end
      end
    end
  end
end