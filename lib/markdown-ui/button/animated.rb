# coding: UTF-8

module MarkdownUI::Button
  class Animated
    def initialize(content, klass = nil, _id = nil)
      @content = content
      @klass = klass
      @id = _id
      @visible_content, @hidden_content = content.is_a?(Array) ? content : content.split(";")
    end

    def render
      klass = "ui #{@klass} animated button"
      _id = @id
      visible_content = MarkdownUI::Content::Parser.new(@visible_content).parse
      hidden_content = MarkdownUI::Content::Parser.new(@hidden_content).parse

      content = []
      if @content.is_a? Array
        content << visible_content
        content << hidden_content
      else
        content << MarkdownUI::StandardTag.new(visible_content, "visible content").render
        content << MarkdownUI::StandardTag.new(hidden_content, "hidden content").render
      end

      MarkdownUI::StandardTag.new(content.join, klass, _id).render
    end
  end
end