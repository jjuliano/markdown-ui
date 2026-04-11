module MarkdownUI
  class HTMLFormatter
    def initialize(text)
      @doc = HtmlBeautifier.beautify(text, indent: "  ")
    end

    def to_html
      @doc
    end
  end
end