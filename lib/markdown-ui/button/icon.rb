# coding: UTF-8

module MarkdownUI::Button
  class Icon
    def initialize(content, klass = nil)
      @klass = klass
      @content = content
    end

    def render
      content = MarkdownUI::Content::Parser.new(@content).parse
      klass = "ui #{@klass} icon button"

      MarkdownUI::StandardTag.new(content, klass).render
    end
  end
end