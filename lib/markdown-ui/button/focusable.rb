# coding: UTF-8

module MarkdownUI::Button
  class Focusable
    def initialize(content, klass = nil)
      @klass = klass
      @content = content
    end

    def render
      content = MarkdownUI::Content::Parser.new(@content).parse
      klass = MarkdownUI::KlassUtil.new("ui #{@klass} button").klass

      output = []
      output << "<button"
      output << "#{klass}>"
      output << content
      output << "</button>"

      output.join
    end
  end
end