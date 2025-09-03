# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for menu UI elements
    class MenuElement < BaseElement
      
      def render
        menu_items = extract_menu_items

        build_menu_html(menu_items)
      end
      
      private
      
      def extract_menu_items
        case @content
        when Array
          # Handle array content - check if we have a single string with multiple items
          if @content.length == 1 && @content.first.is_a?(String)
            content_str = @content.first
            if content_str.include?('|') && !content_str.include?('](')
              # Only split by | if there are no markdown links (which contain | inside)
              content_str.split('|').map(&:strip).reject(&:empty?)
            elsif content_str.include?(',')
              content_str.split(',').map(&:strip).reject(&:empty?)
            elsif content_str.include?("\n") || content_str.include?("\\n")
              # Single string with newlines - split into individual items
              # Convert escaped newlines to actual newlines first
              content_with_newlines = content_str.gsub(/\\n/, "\n")
              lines = content_with_newlines.split("\n").map(&:strip).reject(&:empty?)

              # Process lines to handle nested blockquotes
              processed_items = []
              current_regular_items = []
              nested_blockquote_buffer = []

              lines.each do |line|
                if line.match?(/^>*>\s*\w+.*:/)
                  # This is the start of a nested blockquote
                  if current_regular_items.any?
                    processed_items.concat(current_regular_items)
                    current_regular_items = []
                  end
                  nested_blockquote_buffer << line
                elsif nested_blockquote_buffer.any? && line.match?(/^>*>\s*/)
                  # This is part of the nested blockquote
                  nested_blockquote_buffer << line
                elsif nested_blockquote_buffer.any?
                  # End of nested blockquote - parse it
                  nested_content = nested_blockquote_buffer.join("\n")
                  processed_items << nested_content
                  nested_blockquote_buffer = []
                  current_regular_items << line
                else
                  # Regular item
                  current_regular_items << line
                end
              end

              # Handle any remaining items
              if nested_blockquote_buffer.any?
                nested_content = nested_blockquote_buffer.join("\n")
                processed_items << nested_content
              end
              if current_regular_items.any?
                processed_items.concat(current_regular_items)
              end

              processed_items
            elsif content_str.match?(/\[.*\]\(.*\)/)
              # Single string with markdown links - split on links
              content_str.split(/\s+(?=\[)/).map(&:strip).reject(&:empty?)
            else
              [@content.first]
            end
          else
            # Process array elements and handle Right Menu grouping
            grouped_items = []
            i = 0

            while i < @content.length
              item = @content[i]

              # Check for Right Menu header
              if item == "Right Menu:" && i + 1 < @content.length
                # Combine with next item (the link)
                next_item = @content[i + 1]
                if next_item.match?(/^\[.*\]\(.*\)/)
                  combined = "Right Menu:\n#{next_item}"
                  grouped_items << combined
                  i += 2  # Skip both items
                else
                  # If next item is not a link, treat Right Menu as regular item
                  grouped_items << item
                  i += 1
                end
              else
                # Regular item
                grouped_items << item
                i += 1
              end
            end

            grouped_items
          end
        when String
          # Support comma or pipe separated items
          if @content.include?('|')
            @content.split('|').map(&:strip).reject(&:empty?)
          elsif @content.include?(',')
            @content.split(',').map(&:strip).reject(&:empty?)
          elsif @content.include?("\n")
            # Handle blockquote content that may include element declaration
            lines = @content.split("\n").map(&:strip).reject(&:empty?)
            if lines.first&.match?(/^>\s*[^:]+:\s*$/)
              # First line is UI element declaration, extract content from remaining lines
              content_lines = lines[1..-1]
              # Strip blockquote markers from content lines
              content_lines.map { |line| line.sub(/^>\s*/, '').strip }.reject(&:empty?)
            else
              # Regular blockquote content - split on markdown links if present
              if @content.match?(/\[.*\]\(.*\)/)
                @content.split(/\n(?=\[)/).map(&:strip).reject(&:empty?)
              else
                lines
              end
            end
          else
            [@content.strip].reject(&:empty?)
          end
        else
          []
        end
      end

      def process_mixed_menu_content(content_str)
        lines = content_str.split("\n")
        items = []
        i = 0

        while i < lines.length
          line = lines[i].strip

          if line.empty?
            i += 1
            next
          end

          if line.match?(/^\[.*\]\(.*\)/)
            # This is a markdown link - collect it as a separate item
            items << line
            i += 1
          elsif line.match?(/^>\s*\w+.*:/)
            # This is a nested blockquote header - collect the entire nested block
            nested_lines = collect_nested_block(lines[i..-1])
            items << nested_lines.join("\n")
            i += nested_lines.length
          else
            # Regular content
            items << line
            i += 1
          end
        end

        items.reject(&:empty?)
      end

      def group_nested_items(items)
        grouped = []
        i = 0

        while i < items.length
          item = items[i]

          # Check for combined right menu pattern from extract_menu_items
          if item.start_with?("Right Menu:\n") || item.start_with?("Right Menu:\\n")
            # Extract the link from the combined item
            # Handle both actual and escaped newlines
            item_with_newlines = item.gsub(/\\n/, "\n")
            lines = item_with_newlines.split("\n")
            link_line = lines[1]
            if link_line && link_line.match?(/^(>\s*)*\[.*\]\(.*\)/)
              # Strip blockquote markers and parse the link (handle any nesting level)
              clean_link = link_line.sub(/^(>\s*)*/, '')
              link_match = clean_link.match(/^\[([^\]]+)\]\(([^)\s]+)(?:\s+"([^"]*)")?\)/)
              if link_match
                text = link_match[1]
                url = link_match[2]
              # Create right menu HTML with compact formatting (no extra newlines)
              link_html = %[<a class="ui item" href="#{url}">#{text}</a>]
              right_menu_html = %[<div class="ui right menu">#{link_html}</div>]
                grouped << right_menu_html
                i += 1
                next
              end
            end
          end

          # Check for right menu pattern: "Right Menu:" followed by a markdown link
          if item.downcase.strip == "right menu:" && i + 1 < items.length && items[i + 1].match?(/^\[.*\]\(.*\)/)
            # Parse the markdown link directly
            link_item = items[i + 1]
            link_match = link_item.match(/^\[([^\]]+)\]\(([^)\s]+)(?:\s+"([^"]*)")?\)/)
            if link_match
              text = link_match[1]
              url = link_match[2]

              # Create simple link HTML with compact formatting
              link_html = %[<a class="ui item" href="#{url}">#{text}</a>]
              right_menu_html = %[<div class="ui right menu">#{link_html}</div>]
              grouped << right_menu_html
            else
              # Fallback
              grouped << items[i + 1]
            end
            i += 2 # Skip both items
          elsif item.include?("\n>") && item.match?(/\[.*\]\(.*\)/)
            # This item contains both markdown links and nested blockquotes
            # Split it further
            sub_items = item.split("\n")
            current_group = []

            sub_items.each do |sub_item|
              if sub_item.match?(/^\[.*\]\(.*\)/)
                # This is a markdown link
                if current_group.any?
                  grouped << current_group.join("\n")
                  current_group = []
                end
                grouped << sub_item.strip
              elsif sub_item.match?(/^>\s*[^:]+:\s*$/) && !sub_item.match?(/^>\s*.*\b(menu|button|segment|form|input|field|item|header|container|grid|column)\b.*:\s*$/i)
                # This is a menu title (ends with colon but no content after stripping >)
                # Skip it - don't include in grouped items
              elsif sub_item.match?(/^>\s*\w+.*:/)
                # This is the start of a nested blockquote
                current_group << sub_item
              elsif sub_item.match?(/^>\s*/)
                # This is part of the nested blockquote
                current_group << sub_item
              else
                # Regular content
                current_group << sub_item
              end
            end

            if current_group.any?
              grouped << current_group.join("\n")
            end
            i += 1
          else
            grouped << item
            i += 1
          end
        end

        grouped
      end

      def parse_nested_blockquote(blockquote_content)
        # Parse the nested blockquote content recursively
        require_relative '../parser'
        parser = MarkdownUI::Parser.new
        parsed_html = parser.parse(blockquote_content)

        # Clean up any extra whitespace
        parsed_html.strip
      end

      def collect_nested_block(lines)
        return [] if lines.empty?

        base_line = lines[0]
        base_level = count_blockquote_level(base_line)
        nested_lines = [base_line]

        lines[1..-1].each do |line|
          current_level = count_blockquote_level(line)

          if current_level >= base_level && !line.strip.empty?
            nested_lines << line
          else
            break
          end
        end

        nested_lines
      end

      def count_blockquote_level(line)
        line.match(/^(>+\s*)/)&.[](1)&.count('>') || 0
      end
      
      def build_menu_html(menu_items)
        return %[<div class="#{css_class}"#{html_attributes}></div>] if menu_items.empty?

        # Group nested blockquotes
        grouped_items = group_nested_items(menu_items)
        
        # Post-process to handle right menu items that weren't caught earlier
        final_items = []
        right_menu_items = []
        
        grouped_items.each do |item|
          # Check if this is a right menu related item
          # Only match standalone "Right Menu:" items, not nested blockquotes containing "Right Menu:"
          if item.strip == "Right Menu:" || item.match?(/^Right Menu:$/)
            # Skip the right menu header, collect subsequent items
            next
          elsif item.match?(/^(>\s*)+\[.*\]\(.*\)/) || (right_menu_items.any? && item.match?(/^\[.*\]\(.*\)/))
            # This is a right menu item
            right_menu_items << item
          else
            # Regular item - if we have collected right menu items, wrap them now
            if right_menu_items.any?
              right_html = right_menu_items.map { |ri| parse_markdown_link(ri.sub(/^>\s*>\s*/, '')) }.join
              final_items << %[<div class="ui right menu">#{right_html}</div>]
              right_menu_items.clear
            end
            final_items << item
          end
        end
        
        # Handle any remaining right menu items
        if right_menu_items.any?
          right_html_parts = right_menu_items.map do |ri|
            if ri.match?(/^>/) && ri.include?(':')
              # This is a nested blockquote - parse it recursively
              parsed = parse_nested_blockquote(ri)
              # If it already returns a right menu structure, extract just the inner content
              if parsed.start_with?('<div class="ui right menu">') && parsed.end_with?('</div>')
                inner_content = parsed.sub(/^<div class="ui right menu">/, '').sub(/<\/div>$/, '')
                inner_content
              else
                parsed
              end
            else
              parse_markdown_link(ri.sub(/^>\s*>\s*/, ''))
            end
          end
          final_items << %[<div class="ui right menu">#{right_html_parts.join}</div>]
        end
        
        grouped_items = final_items

        items_html = grouped_items.map do |item|
          if item.start_with?('<div class="ui right menu">')
            # Already processed right menu HTML - include directly
            item
          elsif item.match?(/^\[.*\]\(.*\)/) && !item.match?(/^>/)
            # Markdown link format: [text](url "title")
            parse_markdown_link(item)
          elsif item.match?(/^>/) && item.include?(':')
            # Nested blockquote - check if it's a right menu
            if item.downcase.include?('right menu')
              # Right menu - parse and include directly
              nested_html = parse_nested_blockquote(item)
              # Clean up any unwanted blockquote marker items
              clean_nested_html = nested_html.gsub(/<div class="item">&gt;\s*&gt;<\/div>/, '')
              clean_nested_html
            else
              nested_html = parse_nested_blockquote(item)
              # Other nested elements should be wrapped as items
              %[<div class="item">#{nested_html}</div>]
            end
          elsif item.include?(':') && item.match?(/^https?:/)
            # Link format: "Label:URL"
            parts = item.split(':', 2)
            label = parts[0].strip
            url = parts[1].strip
            %[<a class="item" href="#{escape_html(url)}">#{escape_html(label)}</a>]
          elsif item.include?(':')
            # Special item format: "type:content"
            %[<div class="item">#{escape_html(item)}</div>]
          else
            %[<div class="item">#{escape_html(item)}</div>]
          end
        end

        # Count only non-nested items for CSS class calculation
        non_nested_items = grouped_items.reject { |item| item.match?(/^>\s*\w+.*:/) }

        # Different menus use different formatting
        if has_modifier?('pagination') || has_modifier?('vertical') || has_modifier?('tabular') || has_modifier?('text')
          # Pagination, vertical, tabular, and text menus use multi-line formatting with indentation
          indented_items = items_html.map { |item| "  #{item}" }
          "<div class=\"#{css_class(non_nested_items.length)}\"#{html_attributes}>\n#{indented_items.join("\n")}\n</div>"
        else
          # Regular menus use compact single-line formatting
          result = '<div class="' + css_class(non_nested_items.length) + '"' + html_attributes + '>' + items_html.join + '</div>'
          result.rstrip
        end
      end

      def parse_markdown_link(item)
        # Parse [text](url "title") format
        link_match = item.match(/^\[([^\]]+)\]\(([^)]+)\)/)
        return %[<div class="item">#{escape_html(item)}</div>] unless link_match

        text = link_match[1]
        content = link_match[2].strip

        # Parse content: url "title" or just url
        # Handle escaped quotes
        content = content.gsub(/\\"/, '"')
        if content.include?(' "')
          url, title_part = content.split(' "', 2)
          title = title_part.sub(/"$/, '') if title_part
        else
          url = content
          title = nil
        end

        # Parse title for additional classes
        classes = ['ui']
        if title
          title_parts = title.split
          # Add any class-like parts from title
          title_parts.each do |part|
            classes << part if part.match?(/^[a-zA-Z][a-zA-Z0-9_-]*$/)
          end
        end
        # Only add 'item' if it's not already in the classes
        classes << 'item' unless classes.include?('item')

        class_attr = %( class="#{classes.join(' ')}")

        # Parse nested UI elements in the text content
        if text.include?('__')
          require_relative '../parser'
          parser = MarkdownUI::Parser.new
          parsed_text = parser.parse(text)
          # For menu links, we want the content inline, so strip any block-level formatting
          inline_content = parsed_text.strip
          # Remove <p> tags that Redcarpet adds to plain text
          inline_content = inline_content.sub(/^<p>/, '').sub(/<\/p>$/, '')
          # Clean up newlines for inline display
          inline_content = inline_content.gsub(/\n+/, ' ').strip
          %[<a#{class_attr} href="#{escape_html(url)}">#{inline_content}</a>]
        else
          %[<a#{class_attr} href="#{escape_html(url)}">#{escape_html(text)}</a>]
        end
      end
      
      def element_name
        'menu'
      end
      
      def css_class(item_count = nil)
        classes = ['ui']

        # Add item count modifier if applicable
        if item_count && item_count > 0 && !@modifiers.include?('pagination') && !@modifiers.include?('vertical') && !@modifiers.include?('pointing') && !@modifiers.include?('right') && !@modifiers.include?('secondary') && !@modifiers.include?('tabular') && !@modifiers.include?('text')
          case item_count
          when 1 then classes << 'one'
          when 2 then classes << 'two'
          when 3 then classes << 'three'
          when 4 then classes << 'four'
          when 5 then classes << 'five'
          when 6 then classes << 'six'
          when 7 then classes << 'seven'
          when 8 then classes << 'eight'
          when 9 then classes << 'nine'
          when 10 then classes << 'ten'
          when 11 then classes << 'eleven'
          when 12 then classes << 'twelve'
          when 13 then classes << 'thirteen'
          when 14 then classes << 'fourteen'
          when 15 then classes << 'fifteen'
          when 16 then classes << 'sixteen'
          end
          classes << 'item' if item_count <= 16
        end

        # Add attachment modifiers first (in consistent order)
        attachment_order = %w[top attached bottom]
        attachment_modifiers = attachment_order.select { |mod| @modifiers.include?(mod) }
        classes.concat(attachment_modifiers)

        # Add type modifiers (in consistent order)
        type_order = %w[secondary pointing vertical fluid tabular text popup dropdown pagination right]
        type_modifiers = type_order.select { |mod| @modifiers.include?(mod) }
        classes.concat(type_modifiers)

        # Add appearance modifiers
        appearance_modifiers = @modifiers & %w[inverted borderless stackable]
        classes.concat(appearance_modifiers)

        # Add size modifiers
        size_modifiers = @modifiers & %w[mini tiny small large big huge massive]
        classes.concat(size_modifiers)

        # Add color modifiers
        color_modifiers = @modifiers & %w[red orange yellow olive green teal blue violet purple pink brown grey black]
        classes.concat(color_modifiers)

        classes << 'menu'

        # Merge with any CSS classes from attributes
        if @attributes && @attributes['class']
          custom_classes = Array(@attributes['class'])
          classes.concat(custom_classes)
        end

        classes.join(' ')
      end
    end
  end
end