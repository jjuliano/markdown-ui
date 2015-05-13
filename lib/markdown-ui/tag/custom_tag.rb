# coding: UTF-8

module MarkdownUI
  class CustomTag
    def initialize(tag, content, klass = nil)
      @tag = tag
      @klass = klass
      @content = content
    end

    def render
      klass = MarkdownUI::KlassUtil.new("#{@klass}").klass
      tag = @tag.downcase.strip
      content = MarkdownUI::Content::Parser.new(@content).parse

      output = []
      output << "<#{tag}"
      output << "#{klass}>"
      output << content
      output << "</#{tag}>"

      output.join(" ")
    end
  end
end