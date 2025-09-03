module MarkdownUI
  class HTMLFormatter
    def initialize(text)
      @doc = text
    end

    def to_html
      # Return beautified HTML output
      format_html(@doc)
    end

    private

    def format_html(html)
      # Smart formatter that beautifies HTML with proper indentation

      # Return empty string if html is nil
      return "" if html.nil?

      # Clean up table cells first - remove internal newlines
      html = html.gsub(/(<(?:th|td)[^>]*>)\s*\n\s*(.*?)\s*\n\s*(<\/(?:th|td)>)/m, '\1\2\3')

      # Return the HTML as-is if it's already formatted or very short
      return html if html.include?("\n") || html.length < 50

      # Parse and format the HTML
      formatted = beautify_html(html)
      formatted
    end

    def beautify_html(html)
      # Simple HTML beautifier with proper inline element handling
      result = []
      indent_level = 0
      in_pre = false
      inline_elements = %w[th td span a b i em strong small]

      # Split HTML into tokens while preserving content
      tokens = tokenize_html(html)

      tokens.each_with_index do |token, index|
        if token[:type] == :tag_start
          # Handle pre and textarea tags specially
          if token[:name] =~ /^(pre|textarea)$/i
            in_pre = true
          end

          result << ("  " * [0, indent_level].max) + token[:content]

          # Don't increase indent for inline elements or self-closing tags
          unless token[:self_closing] || token[:name] =~ /^(br|hr|img|input|meta|link|area|base|col|embed|source|track|wbr)/i || inline_elements.include?(token[:name])
            indent_level += 1
          end
        elsif token[:type] == :tag_end
          # Handle end of pre and textarea tags
          if token[:name] =~ /^(pre|textarea)$/i
            in_pre = false
          end

          # For inline elements, check if this is part of a complete inline element
          if inline_elements.include?(token[:name]) && is_complete_inline_element?(tokens, index)
            # This is a complete inline element, don't add newline before closing tag
            result << token[:content]
          else
            indent_level = [0, indent_level - 1].max  # Prevent negative indent
            result << ("  " * indent_level) + token[:content]
          end
        elsif token[:type] == :text
          if in_pre
            result << token[:content]
          else
            content = token[:content].strip
            unless content.empty?
              # Check if this text is part of an inline element
              if is_inline_content?(tokens, index)
                result << content
              else
                result << ("  " * [0, indent_level].max) + content
              end
            end
          end
        else
          result << token[:content]
        end
      end

      result.join("\n") + "\n"
    end

    def is_complete_inline_element?(tokens, end_index)
      # Check if we're at the end of a complete inline element (opening tag + content + closing tag)
      return false unless end_index > 1

      end_token = tokens[end_index]
      content_token = tokens[end_index - 1]
      start_token = tokens[end_index - 2]

      return false unless start_token[:type] == :tag_start && content_token[:type] == :text && end_token[:type] == :tag_end
      return false unless start_token[:name] == end_token[:name]

      inline_elements = %w[th td span a b i em strong small]
      inline_elements.include?(start_token[:name])
    end

    def is_inline_content?(tokens, text_index)
      # Check if this text token is content of an inline element
      return false unless text_index > 0 && text_index < tokens.length - 1

      prev_token = tokens[text_index - 1]
      next_token = tokens[text_index + 1]

      return false unless prev_token[:type] == :tag_start && next_token[:type] == :tag_end
      return false unless prev_token[:name] == next_token[:name]

      inline_elements = %w[th td span a b i em strong small]
      inline_elements.include?(prev_token[:name])
    end

    def tokenize_html(html)
      tokens = []
      i = 0

      while i < html.length
        if html[i] == '<'
          # Find the end of the tag
          tag_end = html.index('>', i)
          if tag_end
            tag_content = html[i..tag_end]

            if tag_content =~ /^<\//
              # Closing tag
              tag_name = tag_content.match(/^<\/([^>\s]+)/)&.[](1) || ""
              tokens << { type: :tag_end, name: tag_name, content: tag_content }
            elsif tag_content =~ /\/>$/
              # Self-closing tag
              tag_name = tag_content.match(/^<([^>\s]+)/)&.[](1) || ""
              tokens << { type: :tag_start, name: tag_name, content: tag_content, self_closing: true }
            else
              # Opening tag
              tag_name = tag_content.match(/^<([^>\s]+)/)&.[](1) || ""
              tokens << { type: :tag_start, name: tag_name, content: tag_content, self_closing: false }
            end

            i = tag_end + 1
          else
            tokens << { type: :text, content: html[i] }
            i += 1
          end
        else
          # Find the next tag or end of string
          next_tag = html.index('<', i)
          if next_tag
            text_content = html[i...next_tag]
            tokens << { type: :text, content: text_content } unless text_content.strip.empty?
            i = next_tag
          else
            text_content = html[i..-1]
            tokens << { type: :text, content: text_content } unless text_content.strip.empty?
            break
          end
        end
      end

      tokens
    end
  end
end
