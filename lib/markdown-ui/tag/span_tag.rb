module MarkdownUI
  class SpanTag
    def initialize(content, klass = nil)
      @klass = klass
      @content = content
    end

    def render
      klass = "#{@klass}".downcase.split(' ').uniq

      "<span class=\'#{klass.join(' ').strip}\'>#{@content}</span>"
    end
  end
end
