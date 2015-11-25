# coding: UTF-8

module MarkdownUI
  class CustomSegment
    def initialize(element, content)
      @element = element
      @content = content
    end

    def render
      element = @element.strip
      content = @content.strip
      klass   = "ui #{element} segment"

      MarkdownUI::StandardTag.new(content, klass).render
    end
  end
end
