# coding: UTF-8

module MarkdownUI::Menu
  class Vertical
    def initialize(content, klass = nil)
      @klass = klass
      @content = content
    end

    def render
      klass = "ui #{@klass} vertical menu"
      content = MarkdownUI::Content::Parser.new(@content).parse

      MarkdownUI::StandardTag.new(content, klass).render
    end
  end
end
