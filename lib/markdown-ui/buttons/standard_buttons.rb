module MarkdownUI
  class StandardButtons
    def initialize(element, content)
      @element = element
      @content = content
    end

    def render
      klass = "ui #{@element} buttons"
      content = @content.strip

      MarkdownUI::StandardTag.new(content, klass).render
    end
  end
end