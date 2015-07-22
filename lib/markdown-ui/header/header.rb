module MarkdownUI
  class Header
    def initialize(text, level)
      @text, @klass = text.split(':')
      @level = level
    end

    def render
      text = @text.strip
      klass = MarkdownUI::KlassUtil.new("ui #{@klass} header").klass
      level = @level

      output = []

      if @level > 0
        output << "<h#{@level}"
        output << klass + ">"
        output << "#{@text}"
        output << "</h#{level}>"
      else
        output << "<div"
        output << klass + ">"
        output << "#{@text}"
        output << "</div>"
      end

      output.join
    end
  end
end
