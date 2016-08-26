module MarkdownUI
  class PaddedSegment
    def initialize(element, content)
      @element = element
      @content = content
    end

    def render
      element = @element.strip
      content = @content.strip
      klass   = "ui #{element} padded segment"

      MarkdownUI::SectionTag.new(content, klass).render
    end
  end
end
