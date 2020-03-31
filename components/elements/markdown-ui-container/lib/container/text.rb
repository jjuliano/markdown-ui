# coding: UTF-8

module MarkdownUI::Container
  class Text
    def initialize(element, content)
      @element = element
      @content = content
    end

    def render
      klass   = "ui #{@element} text container"
      content = @content.strip

      MarkdownUI::StandardTag.new(content, klass).render
    end
  end
end
