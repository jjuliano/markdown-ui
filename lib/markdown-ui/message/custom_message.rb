# coding: UTF-8

module MarkdownUI
  class CustomMessage
    def initialize(element, content, klass = nil)
      @element = element
      @klass = klass
      @content = content
    end

    def render
      element = @element.join(' ').strip
      content = MarkdownUI::Content::Parser.new(@content).parse
      klass = "ui #{element} #{@klass} message"

      MarkdownUI::StandardTag.new(content, klass).render
    end
  end
end

