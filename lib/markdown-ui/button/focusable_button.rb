# coding: UTF-8

module MarkdownUI
  class FocusableButton
    def initialize(content, klass = nil)
      @klass = klass
      @content = MarkdownUI::Content::Parser.new(content).parse
    end

    def render
      klass = "ui #{@klass} button"
      "<button class=\"#{klass.squeeze(' ').strip}\">#{@content}</button>\n"
    end
  end
end