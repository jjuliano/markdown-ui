# coding: UTF-8

module MarkdownUI::Button
  class Custom
    def initialize(element, content, klass = nil)
      @element = element
      @klass = klass
      @content = content
    end

    def render
      element = @element.join(" ").strip
      content = MarkdownUI::Content::Parser.new(@content).parse
      klass = "ui #{element} #{@klass} button"

      MarkdownUI::StandardTag.new(content, klass).render
    end
  end
end

