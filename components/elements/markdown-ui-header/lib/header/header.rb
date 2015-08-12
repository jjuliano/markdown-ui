module MarkdownUI
  class Header
    def initialize(text, level)
      @text, @klass, @_id = text.split(':')
      @level = level
    end

    def render
      text = @text.strip
      klass = MarkdownUI::KlassUtil.new("ui #{@klass} header").klass
      _id = " id=\"#{@_id}\"" if @_id
      level = @level

      output = []

      if @level > 0
        output << "<h#{level}"
        output << _id
        output << klass + ">"
        output << "#{text}"
        output << "</h#{level}>"
      else
        output << "<div"
        output << _id
        output << klass + ">"
        output << "#{text}"
        output << "</div>"
      end

      output.join
    end
  end
end
