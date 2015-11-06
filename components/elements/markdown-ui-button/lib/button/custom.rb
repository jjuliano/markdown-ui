# coding: UTF-8

module MarkdownUI::Button
  class Custom
    def initialize(element, content, klass = nil, _id = nil)
      @element = element
      @klass = klass
      @content = content
      @id = _id
    end

    def render
      element = @element.join(' ').strip
      content = MarkdownUI::Content::Parser.new(@content).parse
      klass = "ui #{element} #{@klass} button"
      _id = @id

      MarkdownUI::ButtonTag.new(content, klass, _id).render
    end
  end
end
