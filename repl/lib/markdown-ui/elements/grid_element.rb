# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for grid UI elements
    class GridElement < BaseElement
      
      def render
        grid_content = extract_grid_content
        columns = determine_columns(grid_content.length)

        build_grid_html(grid_content, columns)
      end
      
      private
      
      def extract_grid_content
        case @content
        when Array
          if @content.length == 1 && (@content.first.to_s.include?("\n") || @content.first.to_s.include?("\\n"))
            # Blockquote syntax: parse multiline content with smart grouping
            content_str = @content.first.to_s
            # Convert escaped newlines to actual newlines
            content_str = content_str.gsub(/\\n/, "\n")
            lines = content_str.split("\n").map(&:strip).reject(&:empty?)
            group_related_content(lines)
          else
            # Double underscore syntax: pipe separated
            @content.map(&:to_s).map(&:strip).reject(&:empty?)
          end
        when String
          if @content.include?("\n")
            # Multiline blockquote content with smart grouping
            lines = @content.split("\n").map(&:strip).reject(&:empty?)
            group_related_content(lines)
          elsif @content.include?('|')
            @content.split('|').map(&:strip).reject(&:empty?)
          elsif @content.include?(',')
            @content.split(',').map(&:strip).reject(&:empty?)
          else
            [@content.strip].reject(&:empty?)
          end
        else
          []
        end
      end

      def group_related_content(lines)
        grouped = []
        i = 0

        while i < lines.length
          line = lines[i]

          if line.match?(/^>\s*[^:]+:\s*$/)
            # This is a UI element declaration
            element_level = count_blockquote_level(line)
            content_lines = [line]
            j = i + 1

            # Collect all lines that belong to this element
            element_text = line.sub(/^>\s*/, '').sub(/:\s*$/, '').downcase
            is_container = element_text.include?('column') || element_text.include?('segment') || element_text.include?('card')

            while j < lines.length
              next_line = lines[j]
              next_level = count_blockquote_level(next_line)

              # If the next line is at the same level and contains content (not another element declaration)
              if next_level == element_level
                if next_line.match?(/^>\s*[^:]+:\s*$/)
                  # Another element declaration at same level
                  if is_container
                    # Container elements can contain other elements as content
                    content_lines << next_line
                    j += 1
                  else
                    # Non-container elements stop here
                    break
                  end
                else
                  # Content at same level belongs to this element
                  content_lines << next_line
                  j += 1
                end
              elsif next_level > element_level
                # Deeper content belongs to this element (nested elements)
                content_lines << next_line
                j += 1
              else
                # Shallower level - stop here
                break
              end
            end

            grouped << content_lines.join("\n")
            i = j
          else
            grouped << line
            i += 1
          end
        end

        grouped
      end

      def count_blockquote_level(line)
        # Count consecutive > characters at the start, allowing for spaces
        count = 0
        i = 0
        while i < line.length
          if line[i] == '>'
            count += 1
            i += 1
          elsif line[i] == ' '
            i += 1
          else
            break
          end
        end
        count
      end
      
      def determine_columns(content_items_count = nil)
        # Check for column number in modifiers
        column_modifier = @modifiers.find { |mod| mod.match?(/\d+/) }
        if column_modifier
          column_modifier.to_i
        else
          # Check for word column numbers
          column_names = {
            'one' => 1, 'two' => 2, 'three' => 3, 'four' => 4,
            'five' => 5, 'six' => 6, 'seven' => 7, 'eight' => 8,
            'nine' => 9, 'ten' => 10, 'eleven' => 11, 'twelve' => 12,
            'thirteen' => 13, 'fourteen' => 14, 'fifteen' => 15, 'sixteen' => 16
          }

          word_column = @modifiers.find { |mod| column_names.key?(mod) }
          if word_column
            column_names[word_column]
          else
            # No explicit column count, use number of items (capped at 4 for reasonable layout)
            count = content_items_count || @content_items.length
            [count, 4].min
          end
        end
      end
      
      def build_grid_html(content_items, columns)
        return %[<div class="#{css_class}"#{html_attributes}></div>] if content_items.empty?

        # Check if all content items are already column elements
        all_columns = content_items.all? do |item|
          parsed = parse_grid_item(item)
          parsed.match?(/class="[^"]*column[^"]*"/)
        end

        if all_columns && content_items.length == 1
          # Single column grid - don't wrap in rows
          parsed_content = parse_grid_item(content_items.first)
          # Add proper indentation
          indented_content = parsed_content.split("\n").map { |line| line.empty? ? line : "  #{line}" }.join("\n")
          %[<div class="#{css_class}"#{html_attributes}>
#{indented_content}
</div>]
        else
          # Standard grid with rows
          rows_html = []
          content_items.each_slice(columns) do |row_items|
            columns_html = row_items.map do |item|
              column_width = determine_column_width(columns)
              # Parse the item content recursively for nested UI elements
              parsed_content = parse_grid_item(item)
              %[    <div class="#{column_width} column">#{parsed_content}</div>]
            end

            rows_html << %[  <div class="row">\n#{columns_html.join("\n")}\n  </div>]
          end

          %[<div class="#{css_class}"#{html_attributes}>
#{rows_html.join("\n")}
</div>]
        end
      end
      
      def parse_grid_item(item)
        # Special handling for menu elements in grid
        if item.match?(/^>\s*.*menu.*:/i) && !item.match?(/^>\s*.*column.*:/i)
          # This is a menu element, create it directly
          require_relative 'menu_element'
          # Convert escaped newlines to actual newlines first
          item_with_newlines = item.gsub(/\\n/, "\n")
          lines = item_with_newlines.split("\n").map(&:strip).reject(&:empty?)
          # Find the menu declaration line
          menu_line_index = lines.find_index { |line| line.match?(/^>+\s*.*menu.*:/i) }
          if menu_line_index
            menu_line = lines[menu_line_index]
            if menu_line.match?(/^>+\s*([^:]+):\s*$/)
              # Extract menu modifiers from the header
              header_content = menu_line.sub(/^>+\s*/, '').sub(/:\s*$/, '').strip
              header_parts = header_content.split(/[:,]\s*|\s+/).map(&:strip).reject(&:empty?)

              # Find menu in header parts
              menu_index = header_parts.find_index { |part| part.downcase == 'menu' }
              if menu_index
                modifiers = header_parts.reject { |part| part.downcase == 'menu' }

                # Extract menu items from lines after the menu declaration
                menu_items = []
                lines[menu_line_index + 1..-1].each do |line|
                  # Strip blockquote markers down to the menu level
                  menu_level = menu_line.count('>')
                  clean_line = line.dup
                  # Strip blockquote markers until we're at the same level as the menu
                  while clean_line.match?(/^>\s*/) && clean_line.count('>') > menu_level
                    clean_line = clean_line.sub(/^>\s*/, '').strip
                  end
                  # If the line is at the same level as the menu, strip the final level to get the content
                  if clean_line.count('>') == menu_level && clean_line.match?(/^>\s*/)
                    clean_line = clean_line.sub(/^>\s*/, '').strip
                  end
                  menu_items << clean_line if !clean_line.empty?
                end

                # Create and render menu element
                menu_element = MarkdownUI::Elements::MenuElement.new(
                  menu_items,
                  modifiers,
                  {},
                  'menu'
                )
                return menu_element.render
              end
            end
          end
        end

        # Check if this item looks like a UI element blockquote
        if item.match?(/^>\s*[^:]+:\s*$/)
          # This looks like a UI element blockquote (ends with colon)
          # Use tokenizer to parse it as UI element
          require_relative '../tokenizer'
          tokenizer = MarkdownUI::Tokenizer.new
          tokens = tokenizer.tokenize(item)

          if tokens.any? && tokens.first.type == :ui_element
            # It's a UI element, parse it
            require_relative '../parser'
            parser = MarkdownUI::Parser.new
            return parser.parse(item)
          else
            # Not a UI element, treat as regular markdown
            require_relative '../parser'
            parser = MarkdownUI::Parser.new
            parser.parse(item)
          end
        elsif item.match?(/\[.*\]\(.*\)/)
          # This contains markdown links, treat as markdown content
          require_relative '../parser'
          parser = MarkdownUI::Parser.new
          parser.parse(item)
        elsif item.start_with?('>')
          # This is a regular markdown blockquote
          require_relative '../parser'
          parser = MarkdownUI::Parser.new
          parser.parse(item)
        else
          # Regular content, just escape HTML
          escape_html(item)
        end
      end

      def determine_column_width(columns)
        width_names = {
          1 => 'sixteen wide', 2 => 'eight wide', 3 => 'five wide', 4 => 'four wide',
          5 => 'three wide', 6 => 'two wide', 8 => 'two wide', 12 => 'one wide', 16 => 'one wide'
        }
        width_names[columns] || 'wide'
      end
      
      def element_name
        'grid'
      end
      
      def css_class
        classes = ['ui']
        
        # Add column count modifiers (handled in determine_columns)
        column_modifiers = @modifiers.select { |mod| 
          mod.match?(/\d+/) || %w[one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen].include?(mod)
        }
        classes.concat(column_modifiers.select { |mod| mod.match?(/\A(one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve|thirteen|fourteen|fifteen|sixteen)\z/) })
        
        # Add appearance modifiers
        appearance_modifiers = @modifiers & %w[stackable doubling relaxed very relaxed padded equal width celled]
        classes.concat(appearance_modifiers)
        
        # Add alignment modifiers
        alignment_modifiers = @modifiers & %w[left aligned center aligned right aligned]
        classes.concat(alignment_modifiers)
        
        classes << 'grid'
        classes.join(' ')
      end
    end
  end
end