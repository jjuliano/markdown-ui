module MarkdownUI
  class StandardContainer
    def initialize(element, content)
      @element = element
      @content = content
    end

    def render
      klass = "ui #{@element} container".downcase.split(" ").uniq

      "<div class=\"#{klass.join(" ").strip}\">#{@content}</div>\n"
    end
  end
end