# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for header UI elements
    class HeaderElement < BaseElement
      
      def render
        level = determine_header_level
        header_text = extract_header_text
        sub_header = extract_sub_header
        
        build_header_html(level, header_text, sub_header)
      end
      
      private
      
      def determine_header_level
        # Check for h1, h2, h3, etc. in modifiers
        level_modifier = @modifiers.find { |mod| mod.match?(/^h[1-6]$/) }
        if level_modifier
          level_modifier[1].to_i
        else
          # Check for size modifiers and map to header levels
          size_to_level = {
            'huge' => 1, 'massive' => 1,
            'large' => 2, 'big' => 2, 
            'medium' => 3,
            'small' => 4,
            'tiny' => 5, 'mini' => 6
          }
          
          size_modifier = @modifiers.find { |mod| size_to_level.key?(mod) }
          size_to_level[size_modifier] || 3 # default to h3
        end
      end
      
      def extract_header_text
        case @content
        when Array
          first_content = @content.first.to_s.strip
          # Handle multi-line content: only use the first line for the header
          first_line = first_content.split("\n").first.strip
          # Parse modifiers from colon syntax if present
          if first_line.include?(':')
            text_parts = first_line.split(':', 2)
            header_text = text_parts[0].strip
            modifiers_text = text_parts[1].strip
            if !modifiers_text.empty?
              additional_modifiers = modifiers_text.split(',').map(&:strip).map(&:downcase)
              @modifiers.concat(additional_modifiers)
            end
            first_line = header_text
          end
          # Store remaining content for later use
          @remaining_content = first_content.split("\n")[1..-1]&.join("\n")&.strip
          first_line
        when String
          # Handle "Header Text|Sub Header" format
          header_part = @content.split('|').first.to_s.strip
          # Handle multi-line content: only use the first line for the header
          first_line = header_part.split("\n").first.strip
          # Parse modifiers from colon syntax if present
          if first_line.include?(':')
            text_parts = first_line.split(':', 2)
            header_text = text_parts[0].strip
            modifiers_text = text_parts[1].strip
            if !modifiers_text.empty?
              additional_modifiers = modifiers_text.split(',').map(&:strip).map(&:downcase)
              @modifiers.concat(additional_modifiers)
            end
            first_line = header_text
          end
          # Store remaining content for later use
          @remaining_content = header_part.split("\n")[1..-1]&.join("\n")&.strip
          first_line
        else
          ''
        end
      end
      
      def extract_sub_header
        case @content
        when Array
          @content[1].to_s.strip if @content.length > 1
        when String
          if @content.include?('|')
            @content.split('|')[1].to_s.strip
          end
        end
      end
      
      def build_header_html(level, header_text, sub_header)
        # Use div tag for floated headers, h# tag for others
        if @modifiers.any? { |mod| mod.include?('floated') }
          tag_name = "div"
        else
          tag_name = "h#{level}"
        end

        content_html = escape_html(header_text)

        if sub_header && !sub_header.empty?
          content_html += %[\n  <div class="sub header">#{escape_html(sub_header)}</div>]
        end

        # Don't add trailing newline for attached headers
        is_attached = @modifiers.any? { |mod| mod.include?('attached') || mod.include?('top') || mod.include?('bottom') }

        # Build the HTML explicitly to avoid interpolation issues
        opening_tag = "<" + tag_name + " class=\"" + css_class + "\"" + html_attributes + ">"
        closing_tag = "</" + tag_name + ">"
        result = opening_tag + content_html + closing_tag

        # Handle remaining content from multi-line headers (don't add newline before remaining content for attached headers)
        if @remaining_content && !@remaining_content.empty?
          # Special handling for attached headers with segment content
          if is_attached && @remaining_content.match?(/Attached Segment:/)
            # Parse segment content specifically
            segment_content = extract_segment_content(@remaining_content)
            if segment_content
              require_relative 'segment_element'
              segment_element = MarkdownUI::Elements::SegmentElement.new(
                segment_content,
                ['attached'],
                {},
                'segment'
              )
              remaining_html = segment_element.render.rstrip
              result += remaining_html
            else
              # Fallback to regular parsing
              require_relative '../parser'
              parser = MarkdownUI::Parser.new
              remaining_html = parser.parse(@remaining_content)
              result += "\n" + remaining_html.strip
            end
          else
            # Parse the remaining content as markdown
            require_relative '../parser'
            parser = MarkdownUI::Parser.new
            remaining_html = parser.parse(@remaining_content)
            result += "\n" + remaining_html.strip
          end
        end

        # Don't add final newline for attached headers (they will be followed by attached segments)
        # result += "\n" unless is_attached
        result
      end
      
      def extract_segment_content(content)
        # Extract content after "Attached Segment:" marker
        if content.match?(/Attached Segment:/)
          # Find the segment content after the marker
          lines = content.split("\n")
          segment_lines = []
          found_marker = false

          lines.each do |line|
            if line.include?("Attached Segment:")
              found_marker = true
              next
            elsif found_marker && line.strip.start_with?(">")
              # Extract content from blockquote
              cleaned_line = line.sub(/^>\s*/, '').strip
              # Remove surrounding quotes if present
              cleaned_line = cleaned_line.gsub(/^"(.*)"$/, '\1') if cleaned_line.start_with?('"') && cleaned_line.end_with?('"')
              segment_lines << cleaned_line
            end
          end

          segment_lines.reject(&:empty?).join("\n") if segment_lines.any?
        end
      end

      def element_name
        'header'
      end
      
      def css_class
        classes = ['ui']

        # Split compound modifiers and flatten
        all_modifiers = @modifiers.flat_map { |mod| mod.split }

        # Add positional modifiers first (for correct ordering like "right floated")
        positional_modifiers = all_modifiers & %w[right left center justified]
        classes.concat(positional_modifiers)

        # Add semantic modifiers
        semantic_modifiers = all_modifiers & %w[block attached top bottom dividing icon sub inverted floated]
        classes.concat(semantic_modifiers)

        # Add color modifiers
        color_modifiers = all_modifiers & %w[red orange yellow olive green teal blue violet purple pink brown grey black]
        classes.concat(color_modifiers)

        # Add size modifiers (excluding h1-h6 which are handled as tag names)
        size_modifiers = all_modifiers & %w[huge massive large big medium small tiny mini]
        classes.concat(size_modifiers)

        # Filter out h1-h6 from classes
        classes = classes.reject { |cls| cls.match?(/^h[1-6]$/) }

        classes << 'header'
        classes.join(' ')
      end
    end
  end
end