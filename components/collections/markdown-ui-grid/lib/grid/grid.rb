# coding: UTF-8
module MarkdownUI
  module Grid
    class Grid < MarkdownUI::Shared::TagKlass
      def initialize(_element, _content)
        @element = _element
        @content = _content
      end

      def render
        @klass = "ui #{element} grid"

        MarkdownUI::StandardTag.new(content, klass_text).render
      end
    end
  end
end
