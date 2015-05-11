module MarkdownUI
  class StandardSegment
    def initialize(element, content)
      @element = element
      @content = content
    end

    def render
      klass = "ui #{@element} segment".downcase.split(" ").uniq

      "<div class=\"#{klass.join(" ").strip}\">#{@content}</div>\n"
    end
  end
end