module MarkdownUI
  class StackedSegment
    def initialize(element, content)
      @element = element
      @content = content
    end

    def render
      klass = "ui #{@element} stacked segment".downcase.split(" ").uniq

      return "<div class=\"#{klass.join(" ").strip}\">#{@content}</div>\n"
    end
  end
end