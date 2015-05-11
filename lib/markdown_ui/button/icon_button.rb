# coding: UTF-8

module MarkdownUI
  class IconButton
    def initialize(content, klass = nil)
      @klass = klass.downcase if klass
      @content = MarkdownUI::Content::Parser.new(content).parse
    end

    def render
      klass = "ui #{@klass} icon button".squeeze(' ').strip
      "<div class=\"#{klass}\">#{@content.strip}</div>\n"
    end
  end
end