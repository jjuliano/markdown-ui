# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for comment UI elements (comment threads)
    class CommentElement < BaseElement
      
      def render
        author, content, avatar = extract_comment_content

        build_comment_html(author, content, avatar)
      end
      
      private
      
      def extract_comment_content
        content_str = case @content
                      when Array
                        @content.join("\n")
                      when String
                        @content
                      else
                        ''
                      end

        # Handle escaped newlines and quotes
        content_str = content_str.gsub(/\\n/, "\n").gsub(/\\"/, '"')
        lines = content_str.split("\n").map(&:strip).reject(&:empty?)

        if lines.length >= 2
          # First line contains avatar and author
          first_line = lines[0]

          # Extract avatar image
          avatar_match = first_line.match(/!\[([^\]]*)\]\(([^)]+)\)/)
          avatar = avatar_match ? { alt: avatar_match[1], src: avatar_match[2] } : nil

          # Extract author (remove avatar markdown and bold formatting)
          author_text = first_line.gsub(/!\[([^\]]*)\]\(([^)]+)\)/, '').gsub(/\*\*(.*?)\*\*/, '\1').strip

          # Remaining lines are the comment content
          comment_text = lines[1..-1].join(' ')

          [author_text, comment_text, avatar]
        else
          # Fallback for simple content
          [content_str.strip, '', nil]
        end
      end
      
      def build_comment_html(author, content, avatar)
        comment_html = []

        comment_html << %[<div class="#{css_class}"#{html_attributes}>]

        # Avatar section
        if avatar && avatar.is_a?(Hash)
          comment_html << %[  <div class="avatar">]
          comment_html << %[    <img src="#{escape_html(avatar[:src])}" alt="#{escape_html(avatar[:alt])}" />]
          comment_html << %[  </div>]
        end

        # Content section
        comment_html << %[  <div class="content">]

        # Author
        unless author.empty?
          comment_html << %[    <div class="author">#{escape_html(author)}</div>]
        end

        # Comment text
        unless content.empty?
          comment_html << %[    <div class="text">#{escape_html(content)}</div>]
        end

        comment_html << %[  </div>]
        comment_html << %[</div>]

        comment_html.join("\n") + "\n"
      end
      
      def element_name
        'comment'
      end
      
      def css_class
        classes = ['ui']
        
        # Add state modifiers
        state_modifiers = @modifiers & %w[collapsed minimal]
        classes.concat(state_modifiers)
        
        # Add appearance modifiers
        appearance_modifiers = @modifiers & %w[threaded]
        classes.concat(appearance_modifiers)
        
        classes << 'comment'
        classes.join(' ')
      end
    end
  end
end