# coding: UTF-8

module MarkdownUI::Button
  class Icon
    def initialize(content, klass = nil, _id = nil)
      @klass = klass
      @id = _id
      @content = content
    end

    def render
      content = MarkdownUI::Content::Parser.new(@content).parse
      klass = "ui #{@klass} icon button"
      _id = @id

      MarkdownUI::ButtonTag.new(content, klass, _id).render
    end
  end
end
