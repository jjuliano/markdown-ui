module MarkdownUI
  class PiledSegment
    def initialize(element, content)
      @element = element
      @content = content
    end

    def render
      klass = "ui #{@element} piled segment".downcase.split(" ").uniq

      return "<div class=\"#{klass.join(" ").strip}\">#{@content}</div>\n"
    end
  end
end