# coding: UTF-8

module MarkdownUI
  class CustomTag
    def initialize(_tag, _content, _klass = nil)
      @tag = _tag
      @klass = _klass
      @content = _content
    end

    def render
      output = []
      output << "<#{tag}"
      output << "#{klass}>"
      output << content
      output << "</#{tag}>"

      output.join(' ')
    end

    protected

    def content
      MarkdownUI::Content::Parser.new(@content).parse
    end

    def tag
      @tag.downcase.strip
    end

    def klass
      MarkdownUI::KlassUtil.new("#{@klass}").klass
    end
  end
end
