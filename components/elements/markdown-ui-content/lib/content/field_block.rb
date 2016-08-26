# coding: UTF-8

module MarkdownUI
  module Content
    class FieldBlock
      def initialize(element, content)
        @element = element
        @content = content
      end

      def render
        klass   = "ui #{@element} field"
        content = @content.strip

        MarkdownUI::FieldTag.new(content, klass).render
      end
    end
  end
end
