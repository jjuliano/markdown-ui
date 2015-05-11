# coding: UTF-8

module MarkdownUI
  class TextContainer
    def initialize(element, content)
      @element = element
      @content = content
    end

    def render
      klass = "ui #{@element} text container".downcase.split(" ").uniq

      "<div class=\"#{klass.join(" ").strip}\">#{@content}</div>\n"
    end
  end
end