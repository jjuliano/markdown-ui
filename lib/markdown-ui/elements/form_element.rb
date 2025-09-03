# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    class FormElement < BaseElement
      def render
        content_str = @content.is_a?(Array) ? @content.join("\n") : @content.to_s

        # Parse nested markdown elements if present
        if content_str.include?('__') || content_str.include?('>') || content_str.match?(/^>*>\s*\w+.*:/)
          require_relative '../parser'
          parser = MarkdownUI::Parser.new
          raw_content_html = parser.parse(content_str)

          # Group consecutive field + input pairs
          content_html = group_field_inputs(raw_content_html)
        else
          content_html = parse_nested_content(content_str)
        end

        # Return properly formatted HTML with indentation
        if content_html.strip.empty?
          opening_tag('form') + closing_tag('form') + "\n"
        else
          # Forms with buttons should not have trailing newlines
          has_button = content_html.include?('<button')
          if has_button
            opening_tag('form') + "\n" + indent_content(content_html) + "\n" + closing_tag('form')
          else
            opening_tag('form') + "\n" + indent_content(content_html) + "\n" + closing_tag('form') + "\n"
          end
        end
      end
      
      def element_name
        'form'
      end

      private

      def indent_content(content, level = 1)
        indent = "  " * level
        content.split("\n").map do |line|
          line.strip.empty? ? line : "#{indent}#{line.rstrip}"
        end.join("\n")
      end

      def group_field_inputs(content_html)
        # First unescape any escaped newlines
        content_html = content_html.gsub(/\\n/, "\n")

        lines = content_html.split("\n")
        result = []
        i = 0


        in_fields_container = false

        while i < lines.length
          line = lines[i].strip

          # Handle Fields header
          if line.match?(/^<p>Fields?:/)
            result << '<div class="fields">'
            in_fields_container = true
            # Skip the entire Fields paragraph block
            while i < lines.length && !lines[i].strip.match?(/<\/p>/)
              i += 1
            end
            i += 1  # Skip the closing </p> as well
            next
          end

          # Skip other unwanted elements
          if line.match?(/^<p[^>]*>\\?n<\/p>$/) || line.match?(/^<p><\/p>$/) || line.strip.empty?
            i += 1
            next
          end

          # Check if this is a field element (not fields container)
          if line.match?(/^<div class="[^"]*field[^"]*"[^>]*>$/) && !line.match?(/fields/)
            field_lines = []
            depth = 0
            j = i

              # Collect all lines of the field
            while j < lines.length
              # Preserve original line formatting
              field_lines << lines[j]
              if lines[j].strip.match?(/^<div/)
                depth += 1
              elsif lines[j].strip.match?(/^<\/div>/)
                depth -= 1
                if depth == 0
                  break
                end
              end
              j += 1
            end

            # Check if the next non-empty element is an input
            input_lines = []
            k = j + 1  # Start looking after the field's closing tag
            while k < lines.length
              next_line = lines[k].strip
              if next_line.empty? || next_line.match?(/^<p[^>]*>\\?n<\/p>$/) || next_line.match?(/^<p><\/p>$/)
                k += 1
                next
              elsif next_line.match?(/^<div class="[^"]*input[^"]*">/)
                # Found input, collect all its lines
                input_depth = 0
                m = k
                while m < lines.length
                  # Preserve original input line formatting
                  input_lines << lines[m]
                  if lines[m].strip.match?(/^<div/)
                    input_depth += 1
                  elsif lines[m].strip.match?(/^<\/div>/)
                    input_depth -= 1
                    if input_depth == 0
                      break
                    end
                  end
                  m += 1
                end
                break
              else
                # Not an input, stop looking
                break
              end
            end

            if input_lines.any?
              # Insert input into field (before the closing </div>) with proper indentation
              indented_input_lines = input_lines.map do |line|
                if line.strip.empty?
                  line
                else
                  "  #{line.rstrip}"
                end
              end
              field_lines.insert(-2, *indented_input_lines)
              result.concat(field_lines)
              i = m
            else
              result.concat(field_lines)
              i = j
            end
          else
            result << lines[i]
          end

          i += 1
        end

        final_result = result.join("\n").gsub(/\n\n+/, "\n")

        # For equal width forms, ensure proper indentation for fields within fields container
        if has_modifier?('equal') && final_result.include?('<div class="fields">')
          # Replace the existing fields container with properly indented content
          # Extract content between fields tags and re-indent it
          # Use a more specific pattern that matches the fields container closing div
          # Look for the closing div that comes after all the field content
          fields_pattern = /(<div class="fields">\n)(.*)(\n<\/div>\s*$)/m
          if final_result =~ fields_pattern
            fields_content = $2
            # Apply consistent indentation for fields within the fields container
            lines = fields_content.split("\n")
            indented_lines = []
            depth_stack = []
            
            lines.each do |line|
              stripped = line.strip
              next indented_lines << line if stripped.empty?
              
              if stripped.match?(/^<div class="field"/)
                indented_lines << "  #{stripped}"
                depth_stack.push('field')
              elsif stripped.match?(/^<label/)
                indented_lines << "    #{stripped}"
              elsif stripped.match?(/^<div class="ui input"/)
                indented_lines << "    #{stripped}"
                depth_stack.push('input')
              elsif stripped.match?(/^<input/)
                indented_lines << "      #{stripped}"
              elsif stripped == "</div>"
                context = depth_stack.pop || 'field'  # Default to field if stack is empty
                if context == 'input'
                  indented_lines << "    #{stripped}"  # Input closing div - same level as input opening
                else
                  indented_lines << "  #{stripped}"   # Field closing div - same level as field opening
                end
              else
                indented_lines << "    #{stripped}"
              end
            end
            
            indented_content = indented_lines.join("\n")
            final_result.sub!(fields_pattern, "\\1#{indented_content}\\3")
          end
        end

        # Close fields container if we opened one and it's not already closed
        if in_fields_container && !final_result.end_with?("</div>")
          final_result += "\n</div>"
        end

        final_result
      end

      def find_matching_close(lines, start_index, tag_name)
        depth = 0
        i = start_index

        while i < lines.length
          line = lines[i].strip
          if line.match?(/^<#{tag_name}/)
            depth += 1
          elsif line.match?(/^<\/#{tag_name}>/)
            depth -= 1
            if depth == 0
              return i
            end
          end
          i += 1
        end

        start_index # Return start if no matching close found
      end
    end
  end
end