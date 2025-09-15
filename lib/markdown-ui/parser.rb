module MarkdownUI
  class Parser
    def initialize
      @parser = Redcarpet::Markdown.new(
        MarkdownUI::Renderer,
        autolink: true,
        tables: true,
        fenced_code_blocks: true,
        disable_indented_code_blocks: false,
        strikethrough: true,
        superscript: false,
        underline: false,
        quote: true,
        footnotes: false,
        highlight: false,
        no_intra_emphasis: false
      )
    end

    def render(markdown)
      # Handle nil or invalid input gracefully
      return '' if markdown.nil? || !markdown.respond_to?(:to_s)

      # Ensure we have a string
      markdown_str = markdown.to_s
      return '' if markdown_str.nil? || markdown_str.empty?

      markdown_str = markdown_str.strip
      return '' if markdown_str.empty?

      # Handle standalone quotes that cause parsing errors
      if markdown_str == '"' || markdown_str == '""' || markdown_str == '" "' ||
         markdown_str == "'" || markdown_str == "''" || markdown_str == "' '"
        return '<p></p>'
      end

      @parser.render(markdown_str)
    rescue => e
      # Log error and return safe fallback
      puts "MarkdownUI parsing error: #{e.message}"
      "<div class='ui error message'>Error parsing markdown</div>"
    end
  end
end

