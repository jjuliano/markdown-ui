# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for container UI elements
    class ContainerElement < BaseElement
      
      def render
        content_text = extract_content_text
        
        build_container_html(content_text)
      end
      
      private
      
      def extract_content_text
        content_text = case @content
                      when Array
                        @content.join("\n")  # Join with newlines to preserve line structure
                      when String
                        @content
                      else
                        ''
                      end

        content_text
      end
      
      def build_container_html(content_text)
        if content_text.empty?
          %[<div class="#{css_class}"#{html_attributes}></div>]
        else
          # Parse content as markdown
          parsed_content = parse_markdown_content(content_text)

          # For containers with alignment modifiers, don't add internal whitespace
          if @modifiers.any? { |mod| %w[left right center justified].include?(mod) }
            %[<div class="#{css_class}"#{html_attributes}>#{parsed_content}</div>\n]
          else
            %[<div class="#{css_class}"#{html_attributes}>\n#{parsed_content}\n</div>\n]
          end
        end
      end
      
      def parse_markdown_content(text)
        return '' if text.nil? || text.empty?

        content_str = text.to_s.strip

        # Check if content contains markdown elements or UI elements
        has_markdown = content_str.include?('#') || content_str.include?('"') || content_str.match?(/^>*>\s*\w+.*:/)

        if has_markdown
          # Parse as markdown
          # Handle escaped newlines and quotes
          content_str = content_str.gsub(/\\n/, "\n").gsub(/\\"/, '"')
          lines = content_str.split("\n").map(&:strip).reject(&:empty?)

          parsed_lines = []

          lines.each do |line|
            if line =~ /^#\s*(.+)$/
              # Header
              header_text = $1
              parsed_lines << %[<h1 class="ui header">#{escape_html(header_text)}</h1>]
            elsif line =~ /^>*>\s*\w+.*:/
              # UI element (blockquote syntax) - parse recursively
              require_relative '../parser'
              parser = MarkdownUI::Parser.new
              parsed_element = parser.parse(line)
              parsed_lines << parsed_element.strip
            elsif line =~ /^"(.+)"$/
              # Quoted paragraph
              para_text = $1
              parsed_lines << %[<p>#{escape_html(para_text)}</p>]
            else
              # Regular paragraph
              parsed_lines << %[<p>#{escape_html(line)}</p>]
            end
          end

          parsed_lines.map { |line| "  #{line}" }.join("\n")
        else
          # For simple content, handle quoted text as paragraphs
          if content_str =~ /^"(.+)"$/
            # Quoted text becomes a paragraph
            para_text = $1
            %[<p>#{escape_html(para_text)}</p>]
          else
            # Plain text
            escape_html(content_str)
          end
        end
      end

      def element_name
        'container'
      end
      
      def css_class
        classes = ['ui']
        
        # Add layout modifiers
        layout_modifiers = @modifiers & %w[fluid text relaxed very relaxed cool]
        classes.concat(layout_modifiers)
        
        # Add alignment modifiers  
        alignment_modifiers = @modifiers & %w[left aligned center aligned right aligned justified]
        classes.concat(alignment_modifiers)
        
        classes << 'container'
        classes.join(' ')
      end
    end
  end
end