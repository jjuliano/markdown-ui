# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    class CommentsElement < BaseElement
      def render
        # Parse the content to extract nested comment structure
        comment_tree = parse_comments_content

        return '' if comment_tree.empty?

        build_comments_html(comment_tree)
      end

      private

      def parse_comments_content
        content_str = @content.is_a?(Array) ? @content.join("\n") : @content.to_s
        content_str = content_str.gsub(/\\n/, "\n").gsub(/\\"/, '"')

        lines = content_str.split("\n").map(&:strip).reject(&:empty?)

        # Parse the nested structure
        parse_comment_blocks(lines)
      end

      def parse_comment_blocks(lines)
        comments = []
        i = 0
        base_nesting_level = nil

        # Skip the "Comments:" header line (with or without blockquote markers)
        if lines.first && lines.first.match?(/^>*\s*Comments:/)
          i = 1
        end

        while i < lines.length
          line = lines[i]
          # Check for Comment: with or without blockquote markers
          if line.match?(/^>*\s*Comment:/)
            # Found a comment block
            absolute_level = count_nesting_level(lines, i)

            # Set base level from first comment
            if base_nesting_level.nil?
              base_nesting_level = absolute_level
            end

            # Calculate relative nesting level
            relative_nesting_level = absolute_level - base_nesting_level

            comment_data = parse_comment_block(lines, i)
            comment_data[:nesting_level] = relative_nesting_level
            comments << comment_data
            i = comment_data[:end_index]
          else
            i += 1
          end
        end

        # Build nested structure
        build_nested_structure(comments)
      end

      def count_nesting_level(lines, current_index)
        # Determine nesting by counting the number of > markers before Comment:
        line = lines[current_index]
        match = line.match(/^(>*)\s*Comment:/)
        return 0 unless match

        # Count the > markers to determine nesting level
        match[1].length
      end

      def build_nested_structure(comments)
        return [] if comments.empty?

        # Sort comments by their nesting level to ensure proper processing order
        sorted_comments = comments.sort_by { |c| c[:nesting_level] }

        # Group comments by nesting level
        root_comments = []
        current_parents = {}

        sorted_comments.each do |comment|
          level = comment[:nesting_level]

          if level == 0
            # Root level comment
            root_comments << comment
            current_parents[level] = comment
          else
            # Nested comment - add to parent
            parent_level = level - 1
            if current_parents[parent_level]
              current_parents[parent_level][:nested_comments] ||= []
              current_parents[parent_level][:nested_comments] << comment
              current_parents[level] = comment
            else
              # If no direct parent, this might be an orphan - add to root for now
              root_comments << comment
              current_parents[level] = comment
            end
          end
        end

        root_comments
      end

      def parse_comment_block(lines, start_index)
        # Find the end of this comment block
        i = start_index + 1
        comment_lines = []
        current_nesting_level = count_nesting_level(lines, start_index)

        while i < lines.length
          line = lines[i]

          # Check if this line starts a new comment
          if line.match?(/^>*\s*Comment:/)
            # Stop parsing this comment block - we found another comment
            break
          end

          # Include lines that belong to current comment's nesting level or higher
          line_nesting = line.match(/^(>*)/)[1].length
          if line_nesting >= current_nesting_level
            # Remove blockquote markers and add to comment content
            clean_line = line.sub(/^>*\s*/, '')
            comment_lines << clean_line
          else
            # Line has lower nesting than current comment - we've gone too far
            break
          end

          i += 1
        end

        # Parse the comment content
        comment_content = comment_lines.join("\n")

        # Extract avatar, author, and text
        avatar = nil
        author = ''
        text = ''

        if !comment_content.empty?
          content_lines = comment_content.split("\n")

          # First content line should have avatar and author
          first_line = content_lines[0] || ''

          # Extract avatar from first line
          avatar_match = first_line.match(/!\[([^\]]*)\]\(([^)]+)\)/)
          avatar = avatar_match ? { alt: avatar_match[1], src: avatar_match[2] } : nil

          # Extract author (remove avatar markdown and bold formatting)
          author = first_line.gsub(/!\[([^\]]*)\]\(([^)]+)\)/, '').gsub(/\*\*(.*?)\*\*/, '\1').strip

          # Remaining lines are the comment text
          text_lines = content_lines[1..-1] || []
          text = text_lines.join("\n")
        end

        {
          avatar: avatar,
          author: author,
          text: text,
          nested_comments: [], # Will be populated by build_nested_structure
          end_index: i
        }
      end

      def build_comments_html(comment_tree)
        html = []
        html << %[<div class="#{css_class}"#{html_attributes}>]

        comment_tree.each do |comment|
          html << build_single_comment_html(comment, 0)
        end

        html << %[</div>]

        html.join("\n") + "\n"
      end

      def build_single_comment_html(comment, indent_level = 0)
        indent = "  " * indent_level
        html = []
        html << %[  <div class="comment">]

        # Avatar
        if comment[:avatar]
          html << %[#{indent}    <div class="avatar">]
          html << %[#{indent}      <img src="#{escape_html(comment[:avatar][:src])}" alt="#{escape_html(comment[:avatar][:alt])}" />]
          html << %[#{indent}    </div>]
        end

        # Content
        html << %[#{indent}    <div class="content">]

        # Author
        unless comment[:author].empty?
          html << %[#{indent}      <div class="author">#{escape_html(comment[:author])}</div>]
        end

        # Text
        unless comment[:text].empty?
          html << %[#{indent}      <div class="text">#{escape_html(comment[:text])}</div>]
        end

        # Nested comments
        unless comment[:nested_comments].empty?
          html << %[#{indent}      <div class="comments">]
          comment[:nested_comments].each do |nested_comment|
            html << %[#{indent}        <div class="comment">]
            if nested_comment[:avatar]
              html << %[#{indent}          <div class="avatar">]
              html << %[#{indent}            <img src="#{escape_html(nested_comment[:avatar][:src])}" alt="#{escape_html(nested_comment[:avatar][:alt])}" />]
              html << %[#{indent}          </div>]
            end
            html << %[#{indent}          <div class="content">]
            unless nested_comment[:author].empty?
              html << %[#{indent}            <div class="author">#{escape_html(nested_comment[:author])}</div>]
            end
            unless nested_comment[:text].empty?
              html << %[#{indent}            <div class="text">#{escape_html(nested_comment[:text])}</div>]
            end
            html << %[#{indent}          </div>]
            html << %[#{indent}        </div>]
          end
          html << %[#{indent}      </div>]
        end

        html << %[#{indent}    </div>]
        html << %[#{indent}  </div>]

        html.join("\n")
      end

      def element_name
        'comments'
      end
    end
  end
end
