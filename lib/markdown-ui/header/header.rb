module MarkdownUI
  class Header
    def initialize(text, level)
      @text, @klass = text.split(":")
      @level = level
    end

    def render
      klass = "ui #{@klass} header".downcase.split(" ").uniq
      "<h#{@level} class=\"#{klass.join(" ").strip}\">#{@text}</h#{@level}>"
    end
  end
end