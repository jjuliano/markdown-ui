# coding: UTF-8
module MarkdownUI
  class Row < MarkdownUI::Shared::TagKlass
    def initialize(_element, _content)
      @element = _element
      @content = _content
    end

    def render
      @klass = "ui #{element} row"

      MarkdownUI::StandardTag.new(content, klass_text).render
    end
  end
end
