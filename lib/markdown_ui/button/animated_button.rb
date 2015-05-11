# coding: UTF-8

module MarkdownUI
  class AnimatedButton
    def initialize(visible_content, hidden_content, klass = nil)
      @klass = klass
      @visible_content = MarkdownUI::Content::Parser.new(visible_content).parse
      @hidden_content = MarkdownUI::Content::Parser.new(hidden_content).parse
    end

    def render
      klass = "ui #{@klass} animated button"
      "<div class=\"#{klass.squeeze(' ').strip}\"><div class=\"visible content\">#{@visible_content}</div><div class=\"hidden content\">#{@hidden_content}</div></div>\n"
    end
  end
end