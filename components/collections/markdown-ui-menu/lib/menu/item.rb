# coding: UTF-8

module MarkdownUI
  module Menu
    class Item < MarkdownUI::Shared::TagKlass
      def initialize(_content, _klass = nil)
        @_klass  = _klass
        @content = _content
      end

      def render
        @klass = "ui #{@_klass} item menu"

        MarkdownUI::NavTag.new(content, klass_text).render
      end
    end
  end
end
