# coding: UTF-8

module MarkdownUI
  class CustomMessage
    def initialize(element, content, klass = nil)
      @element = element
      @klass = klass
      @content = content
    end

    def render
      content = MarkdownUI::Content::Parser.new(@content).parse
      element = @element.downcase
      klass = "ui #{@element} #{@klass} message"

      MarkdownUI::StandardTag.new(content, klass).render
    end
  end
end