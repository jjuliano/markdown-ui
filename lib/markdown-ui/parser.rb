module MarkdownUI
  class Parser
    def initialize
      @parser = Redcarpet::Markdown.new(MarkdownUI::Renderer, quote: true, tables: true, xhtml: true)
    end

    def render(markdown)
      @parser.render(markdown)
    end
  end
end

