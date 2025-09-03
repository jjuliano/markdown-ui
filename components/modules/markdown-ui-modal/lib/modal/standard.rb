# coding: UTF-8

module MarkdownUI
  module Modal
    class Standard
      def initialize(content, klass = nil, _id = nil)
        @klass   = klass
        @id      = _id
        @content = content
      end

      def render
        klass   = "ui #{@klass} modal"
        content = MarkdownUI::Content::Parser.new(@content).parse
        _id     = @id

        MarkdownUI::StandardTag.new(content, klass, _id).render('div')
      end
    end
  end
end