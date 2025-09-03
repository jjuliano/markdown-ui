# coding: UTF-8

module MarkdownUI
  module Content
    class AccordionBlock
      def initialize(element, content)
        @element = element
        @content = content
      end

      def render
        element_class = @element.downcase
        # Remove 'accordion' from element_class if it's already there to avoid duplication
        element_parts = element_class.split(' ')
        element_parts.delete('accordion')
        variation_class = element_parts.empty? ? "" : "#{element_parts.join(' ')} "
        klass = "ui #{variation_class}accordion"

        # Handle nil content
        content_to_parse = @content.nil? ? "" : @content.strip

        # Debug: write content to see what we're getting
        # puts "ACCORDION DEBUG: element='#{@element}', content='#{content_to_parse}'"

        parsed_content = parse_accordion_content(content_to_parse)

        result = %(<div class="#{klass}">
#{parsed_content}</div>
)
        result
      end

      private

      def clean_html_tags(text)
        # Remove HTML tags like <br>, <br/>, etc.
        text.gsub(/<[^>]*>/, '').strip
      end

      def parse_accordion_content(content)
        return content if content.empty?

        # Parse the accordion content from the processed format
        # Handle the case where content is processed HTML from nested blockquotes

        if content.include?('<div class="ui title">')
          # Content is processed HTML from nested blockquotes
          # Extract title and content from the HTML structure
          title_match = content.match(/<div class="ui title">(.*?)<\/div>/m)
          if title_match
            title_content = title_match[1].strip

            # Parse multiple title/content pairs from the combined content
            sections = []
            lines = title_content.split("\n").map(&:strip).reject(&:empty?)

            i = 0
            while i < lines.length
              line = lines[i]

              # Look for title lines
              if line =~ /^Title:\s+(.+)$/i || (i == 0 && !line.include?('Content:'))
                title_text = line.sub(/^Title:\s+/i, '').strip
                title_text = clean_html_tags(title_text)

                # Look for the corresponding content
                content_text = ""
                i += 1
                while i < lines.length && lines[i] && lines[i] !~ /^Title:\s+/i
                  if lines[i] =~ /^Content:\s+(.+)$/i
                    content_text = $1.strip
                    content_text = clean_html_tags(content_text)
                    break
                  end
                  i += 1
                end

                if !title_text.empty? && !content_text.empty?
                  sections << [title_text, content_text]
                end
              else
                i += 1
              end
            end

            # Generate HTML for all sections
            sections_html = sections.map do |title_text, content_text|
              if @element.downcase.include?('fluid') || @element.downcase.include?('inverted')
                "  <div class=\"title\"><i class=\"dropdown icon\"></i>\n    #{title_text}\n  </div>\n  <div class=\"content\">\n    <p>#{content_text}</p>\n  </div>\n"
              else
                "  <div class=\"title\">\n    <i class=\"dropdown icon\"></i>\n    #{title_text}\n  </div>\n  <div class=\"content\">\n    <p>#{content_text}</p>\n  </div>\n"
              end
            end.join("")

            return sections_html
          end
        end

        lines = content.split("").map(&:strip).reject(&:empty?)
        result = []
        i = 0

        # Process pairs of title and content
        title_text = ""
        j = 0
        
        while j < lines.length
          line = lines[j]
          
          # Look for "Content" lines
          if line =~ /^Content\s+(.+)$/i
            content_text = $1.strip
            # Remove trailing HTML tags if present
            content_text = content_text.sub(/<\/[^>]*>$/, '')
            # Remove any trailing HTML tags like <br>
            content_text = content_text.sub(/<[^>]*>$/, '')

            if !title_text.empty? && !content_text.empty?
              # Generate the accordion section
              # Check if this is a fluid or inverted accordion (icon on same line)
              if @element.downcase.include?('fluid') || @element.downcase.include?('inverted')
                result << "  <div class=\"title\"><i class=\"dropdown icon\"></i>"
                result << "    #{title_text}"
                result << "  </div>"
              else
                # Standard format (icon on separate line)
                result << "  <div class=\"title\">"
                result << "    <i class=\"dropdown icon\"></i>"
                result << "    #{title_text}"
                result << "  </div>"
              end
              result << "  <div class=\"content\">"
              result << "    <p>#{content_text}</p>"
              result << "  </div>"
              
              # Reset for next pair
              title_text = ""
            end
          # Look for "Title" lines  
          elsif line =~ /^Title\s+(.+)$/i
            title_text = $1.strip
            # Remove trailing HTML tags from title
            title_text = title_text.sub(/<[^>]*>$/, '')
          # If this line doesn't start with "Content" or "Title", it's probably a title
          elsif line !~ /^Content\s+/i && line !~ /^Title\s+/i
            # If we already have a title, this could be a continuation or new title
            if title_text.empty?
              title_text = line.strip
              # Remove trailing HTML tags from title
              title_text = title_text.sub(/<[^>]*>$/, '')
            end
          end

          j += 1
        end

        if result.empty?
          # Fallback: return original content if parsing failed
          content
        else
          result.join("")
        end
      end
    end
  end
end