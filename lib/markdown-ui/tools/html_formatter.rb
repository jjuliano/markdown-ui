module MarkdownUI
  class HTMLFormatter
    def initialize(text)
      @doc = Nokogiri::XML(text, &:noblanks).to_xhtml(indent: 2)
    end

    def to_html
      @doc
    end
  end
end