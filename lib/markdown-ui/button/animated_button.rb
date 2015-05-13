# coding: UTF-8

module MarkdownUI
  class AnimatedButton
    def initialize(visible_content, hidden_content, klass = nil)
      @klass = klass
      @visible_content = visible_content
      @hidden_content = hidden_content
    end

    def render
      klass = "ui #{@klass} animated button"
      visible_content = MarkdownUI::Content::Parser.new(@visible_content).parse
      hidden_content = MarkdownUI::Content::Parser.new(@hidden_content).parse

      content = []
      content << MarkdownUI::StandardTag.new(visible_content, "visible content").render
      content << MarkdownUI::StandardTag.new(hidden_content, "hidden content").render

      MarkdownUI::StandardTag.new(content.join, klass).render
    end
  end
end