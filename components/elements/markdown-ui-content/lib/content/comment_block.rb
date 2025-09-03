# coding: UTF-8

module MarkdownUI
  module Content
    class CommentBlock
      def initialize(element, content)
        @element = element
        @content = content
      end

      def render
        element_class = @element.downcase
        # Remove 'comment' from element_class if it's already there to avoid duplication
        element_parts = element_class.split(' ')
        element_parts.delete('comment')
        variation_class = element_parts.empty? ? "" : "#{element_parts.join(' ')} "
        klass = "ui #{variation_class}comment"

        parsed_content = parse_comment_content(@content.strip)

        %(<div class="#{klass}">
  #{parsed_content}
</div>)
      end

      private

      def parse_comment_content(content)
        return content if content.empty?

        # The content has already been processed by Redcarpet
        # Parse the HTML structure to extract author and text
        lines = content.lines.map(&:strip).reject(&:empty?)

        author = "Anonymous"
        text_content = ""

        lines.each do |line|
          if line =~ /<strong>(.*?)<\/strong>/
            author = $1.strip
          elsif line =~ /<p>(.*?)<\/p>/
            text_content = $1.strip
          else
            # If no structured content, use the line as text
            text_content = line if text_content.empty?
          end
        end

        # Generate the proper comment structure
        result = []
        result << "<div class=\"content\">"
        result << "  <div class=\"author\">#{author}</div>"
        result << "  <div class=\"text\">#{text_content}</div>"
        result << "</div>"

        result.join("")
      end
    end
  end
end