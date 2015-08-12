# coding: UTF-8

module MarkdownUI::Button
  class Standard
    def initialize(content, klass = nil, _id = nil)
      @klass = klass
      @id = _id
      @content = content
    end

    def render
      klass = "ui #{@klass} button"
      content = MarkdownUI::Content::Parser.new(@content).parse
      _id = @id

      MarkdownUI::ButtonTag.new(content, klass, _id).render
    end
  end
end
