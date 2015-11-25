# coding: UTF-8

module MarkdownUI
  module Content
    class Header
      def initialize(content, klass = nil)
        @content = content
        @klass   = klass
      end

      def render
        klass   = "ui #{@klass} header"
        content = @content.strip

        MarkdownUI::StandardTag.new(content, klass).render
      end
    end
  end
end
