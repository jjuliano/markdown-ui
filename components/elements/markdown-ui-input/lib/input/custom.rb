# coding: UTF-8

module MarkdownUI::Input
  class Custom
    def initialize(element, content, klass = nil, _id = nil)
      @element = element
      @klass   = klass
      @content = content
      @id      = _id
    end

    def render
      element = @element.join(' ').strip
      # content = MarkdownUI::Content::Parser.new(@content).parse
      klass   = "ui #{element} input"
      _id     = @id

      "<div class='#{klass}'><input type='text' placeholder='#{@content}' /></div>"
    end
  end
end
