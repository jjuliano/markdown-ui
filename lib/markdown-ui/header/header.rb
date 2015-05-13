module MarkdownUI
  class Header
    def initialize(text, level)
      @text, @klass = text.split(":")
      @level = level
    end

    def render
      text = @text.strip
      klass = MarkdownUI::KlassUtil.new("ui #{@klass} header").klass
      level = @level

      output = []
      output << "<h#{@level}"
      output << klass
      output <<">#{@text}"
      output << "</h#{level}>"

      output.join
    end
  end
end