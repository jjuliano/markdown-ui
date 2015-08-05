module MarkdownUI
  class StackedSegment
    def initialize(element, content)
      @element = element
      @content = content
    end

    def render
      element = @element.strip
      content = @content.strip
      klass = "ui #{element} stacked segment"

      MarkdownUI::StandardTag.new(content, klass).render
    end
  end
end
