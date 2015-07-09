# coding: UTF-8

module MarkdownUI
  class Column
    def initialize(element, content)
      @element = element
      @content = content
    end

    def render
      element = @element.strip
      content = @content.strip
      klass = "ui #{element} column"

      MarkdownUI::StandardTag.new(content, klass).render
    end
  end
end