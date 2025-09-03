# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for accordion UI elements
    class AccordionElement < BaseElement
      
      def render
        sections = extract_sections

        result = build_accordion_html(sections)
        result + "\n"
      end
      
      private
      
      def extract_sections
        # Handle both original blockquote format and grouped format from tokenizer
        if @content.is_a?(Array)
          # If we have a single string item that contains nested blockquotes, parse it as string format
          if @content.length == 1 && @content.first.is_a?(String) && (@content.first.include?('>') || @content.first.include?("\\n"))
            # Fall through to string format processing
          else
            sections = []
            @content.each do |item|
              if item.include?(':')
                # Grouped format from tokenizer: "Title:Content"
                parts = item.split(':', 2)
                sections << { title: parts[0].strip, content: parts[1].to_s.strip }
              else
                # Fallback: treat as title only
                sections << { title: item.strip, content: '' }
              end
            end
            return sections
          end
        end

        # Handle string format (original blockquote format)
        if @content.is_a?(Array) && @content.length == 1
          content_str = @content.first
        else
          content_str = @content.to_s
        end

        # Parse nested blockquotes
        sections = []
        current_section = nil

        # Handle both actual and escaped newlines
        lines = if content_str.include?("\\n")
          content_str.gsub(/\\n/, "\n").split("\n")
        else
          content_str.split("\n")
        end

        lines.each do |line|
          stripped = line.strip
          next if stripped.empty?

          # Remove blockquote markers
          clean_line = stripped.gsub(/^>+\s*/, '')

          if clean_line.start_with?('Title:')
            # Start new section
            current_section = { title: clean_line.sub(/^Title:\s*/, ''), content: '' }
            sections << current_section
          elsif clean_line.start_with?('Content:')
            # Add content to current section
            if current_section
              content_part = clean_line.sub(/^Content:\s*/, '')
              # Check if content contains UI elements
              if content_part.match?(/^>*>\s*\w+.*:/)
                # Parse recursively
                require_relative '../parser'
                parser = MarkdownUI::Parser.new
                current_section[:content] = parser.parse(content_part).strip
              else
                current_section[:content] = content_part
              end
            end
          elsif current_section && !clean_line.start_with?('Accordion:')
            # Check if this line contains UI elements
            if clean_line.match?(/^>*>\s*\w+.*:/)
              # Parse recursively and append
              require_relative '../parser'
              parser = MarkdownUI::Parser.new
              parsed_content = parser.parse(clean_line).strip
              current_section[:content] += ' ' + parsed_content unless current_section[:content].empty?
              current_section[:content] = parsed_content if current_section[:content].empty?
            else
              # Append to current section content
              current_section[:content] += ' ' + clean_line unless current_section[:content].empty?
              current_section[:content] = clean_line if current_section[:content].empty?
            end
          end
        end

        sections
      end
      
      def parse_section(section_str)
        return nil if section_str.nil? || section_str.strip.empty?
        
        if section_str.include?(':')
          parts = section_str.split(':', 2)
          {
            title: parts[0].strip,
            content: parts[1].strip
          }
        else
          # If no colon, treat as title only
          {
            title: section_str.strip,
            content: ''
          }
        end
      end
      
      def build_accordion_html(sections)
        return %[<div class="#{css_class}"#{html_attributes}></div>] if sections.empty?
        
        accordion_html = []
        accordion_html << %[<div class="#{css_class}"#{html_attributes}>]
        
        sections.each_with_index do |section, index|
          # Title section
          title_class = index == 0 && has_modifier?('active') ? 'active title' : 'title'
          if has_modifier?('fluid') || has_modifier?('inverted')
            # Inline format for fluid/inverted accordions
            accordion_html << %[  <div class="#{title_class}"><i class="dropdown icon"></i>]
            accordion_html << %[    #{escape_html(section[:title])}]
          else
            # Separate line format for standard/styled accordions
            accordion_html << %[  <div class="#{title_class}">]
            accordion_html << %[    <i class="dropdown icon"></i>]
            accordion_html << %[    #{escape_html(section[:title])}]
          end
          accordion_html << %[  </div>]
          
          # Content section  
          content_class = index == 0 && has_modifier?('active') ? 'active content' : 'content'
          accordion_html << %[  <div class="#{content_class}">]
          
          if section[:content].empty?
            accordion_html << %[    <p></p>]
          else
            # Split content by newlines and wrap in paragraphs
            content_lines = section[:content].split("\n").map(&:strip).reject(&:empty?)
            if content_lines.length == 1
              accordion_html << %[    <p>#{escape_html(content_lines.first)}</p>]
            else
              content_lines.each do |line|
                accordion_html << %[    <p>#{escape_html(line)}</p>]
              end
            end
          end
          
          accordion_html << %[  </div>]
        end
        
        accordion_html << %[</div>]
        accordion_html.join("\n")
      end
      
      def element_name
        'accordion'
      end
      
      def css_class
        classes = ['ui']
        
        # Add type modifiers
        type_modifiers = @modifiers & %w[styled fluid inverted]
        classes.concat(type_modifiers)
        
        classes << 'accordion'
        classes.join(' ')
      end
    end
  end
end