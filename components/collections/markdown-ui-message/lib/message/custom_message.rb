# coding: UTF-8

module MarkdownUI
  module Message
    class CustomMessage < MarkdownUI::Shared::TagKlass
      def initialize(_element, _content, _klass = nil)
        @element = _element
        @_klass  = _klass
        @content = _content
      end

      def render
        @klass = "ui #{element} #{@_klass} message"

        MarkdownUI::StandardTag.new(content, klass_text).render
      end
    end
  end
end
