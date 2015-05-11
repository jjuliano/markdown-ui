# coding: UTF-8

module MarkdownUI
  class StandardButton
    def initialize(content, klass = nil)
      @klass = klass
      @content = MarkdownUI::Content::Parser.new(content).parse
    end

    def render
      klass = "ui #{@klass} button"
      "<div class=\"#{klass.squeeze(' ').strip}\">#{@content}</div>\n"
    end
  end
end