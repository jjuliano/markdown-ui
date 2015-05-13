module MarkdownUI
  class StandardTag
    def initialize(content, klass = nil)
      @klass = klass
      @content = content
    end

    def render
      content = @content.strip
      klass = MarkdownUI::KlassUtil.new(@klass).klass

      "<div#{klass}>#{content}</div>"
    end
  end
end