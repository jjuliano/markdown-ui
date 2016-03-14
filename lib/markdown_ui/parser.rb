module MarkdownUI
  class Parser
    def initialize
      @parser = Redcarpet::Markdown.new(MarkdownUI::Renderer, quote: true, tables: true, xhtml: true)
    end

    def render(markdown)
      MarkdownUI::Tools::HTMLFormatter.new(
        @parser.render(markdown)
      ).to_html.strip
    end
  end
end

