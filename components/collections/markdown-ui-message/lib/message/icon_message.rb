# coding: UTF-8

module MarkdownUI
  module Message
    class IconMessage < MarkdownUI::Shared::TagKlass
      def initialize(_content, _klass = nil)
        @_klass  = _klass
        @content = _content
      end

      def render
        @klass = "ui #{@_klass} icon message"

        MarkdownUI::StandardTag.new(content, klass_text).render
      end
    end
  end
end
