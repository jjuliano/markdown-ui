# coding: UTF-8

module MarkdownUI::Button
  class Basic
    def initialize(content, klass = nil, _id = nil)
      @klass = klass
      @content = content
      @id = _id
    end

    def render
      content = MarkdownUI::Content::Parser.new(@content).parse
      klass = "ui #{@klass} basic button"
      _id = @id

      MarkdownUI::ButtonTag.new(content, klass, _id).render
    end
  end
end
