module MarkdownUI
  class StandardSegment
    def initialize(element, content)
      @element = element
      @content = content
    end

    def render
      element = @element.strip.downcase
      # Remove 'segment' from element if it exists to avoid duplication
      element = element.gsub(/\s*segment\s*/, '').strip
      klass   = "ui #{element} segment".strip.gsub(/\s+/, ' ')

      # Check if content contains multiple segments (separated by segment headers)
      if @content && @content.include?('Segment:') && @content.scan(/\w+.*Segment:/).length >= 1
        # Multiple segments detected - parse and render each separately
        segments = parse_multiple_segments(@content)
        return segments.join("")  # Return the joined segments
      else
        # Single segment - process normally
        processed_content = process_single_segment(@content)

        # Clean up the processed content - minified output
        cleaned_content = processed_content.gsub(/<p>(.*?)<\/p>/m) do |match|
          content = $1.strip
          "<p>#{content}</p>"
        end

        # Use section tag for segments
        if cleaned_content.strip.empty?
          "<section#{klass ? " class=\"#{klass}\"" : ""}></section>"
        else
          "<section#{klass ? " class=\"#{klass}\"" : ""}>#{cleaned_content}</section>"
        end
      end
    end

    private

    def parse_multiple_segments(content)
      segments = []
      lines = content.split("")
      current_segment = @element  # Start with the original segment type
      current_content = []

      lines.each do |line|
        if line.strip =~ /^(\w+.*)Segment:/i
          # Found a new segment header
          if current_segment && !current_content.empty?
            # Process previous segment
            segment_html = render_single_segment(current_segment, current_content.join(""))
            segments << segment_html
          end
          current_segment = $1.strip
          current_content = []
        elsif current_segment
          current_content << line
        end
      end

      # Process the last segment
      if current_segment && !current_content.empty?
        segment_html = render_single_segment(current_segment, current_content.join(""))
        segments << segment_html
      end

      segments
    end

    def render_single_segment(segment_type, content)
      # Create a temporary segment instance to render this segment
      temp_segment = self.class.new(segment_type, content)
      # Temporarily remove the debug output for the recursive call
      temp_segment.define_singleton_method(:render) do
        element = segment_type.strip.downcase
        element = element.gsub(/\s*segment\s*/, '').strip
        klass = "ui #{element} segment".strip.gsub(/\s+/, ' ')

        processed_content = process_single_segment(content)

        # Clean up the processed content - minified output
        cleaned_content = processed_content.gsub(/<p>(.*?)<\/p>/m) do |match|
          inner_content = $1.strip
          "<p>#{inner_content}</p>"
        end

        if cleaned_content.strip.empty?
          "<section#{klass ? " class=\"#{klass}\"" : ""}></section>"
        else
          "<section#{klass ? " class=\"#{klass}\"" : ""}>#{cleaned_content}</section>"
        end
      end
      temp_segment.render
    end

    def process_single_segment(content)
      # Process content through markdown parser if it exists
      processed_content = content
      if content
        content_to_process = content.strip
        if !content_to_process.empty?
          # Check if content is already HTML (contains HTML tags) or contains HTML entities
          if content_to_process =~ /<\/?[a-zA-Z][^>]*>/ || content_to_process =~ /&[a-zA-Z]+;/
            # Content is already HTML or contains entities, don't process through Redcarpet
            processed_content = content_to_process
            # Ensure it's wrapped in <p> tags if it doesn't already contain block elements
            # But don't wrap if it contains buttons or other inline elements that shouldn't be in paragraphs
            if processed_content !~ /<\/?(div|p|section|article|header|footer)[^>]*>/i && processed_content !~ /<\/?button[^>]*>/i
              processed_content = "<p>#{processed_content}</p>"
            end
          else
            # Parse the content through Redcarpet to convert markdown to HTML
            require 'redcarpet'
            renderer = Redcarpet::Render::HTML.new
            markdown = Redcarpet::Markdown.new(renderer)
            processed_content = markdown.render(content_to_process)
          end
        else
          # Empty content should produce <p></p>
          processed_content = "<p></p>"
        end
      else
        # No content should produce <p></p>
        processed_content = "<p></p>"
      end
      processed_content
    end
  end
end
