# coding: UTF-8

module MarkdownUI
  module Content
    class SpanBlock
      def initialize(element, content)
        @element = element
        @content = content
      end

      def render
        klass = "#{@element}"
        content = @content.strip

        MarkdownUI::SpanTag.new(content, klass).render
      end
    end
  end
end
