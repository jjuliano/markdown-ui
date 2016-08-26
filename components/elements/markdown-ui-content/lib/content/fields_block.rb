# coding: UTF-8

module MarkdownUI
  module Content
    class FieldsBlock
      def initialize(element, content)
        @element = element
        @content = content
      end

      def render
        klass   = "ui #{@element} fields"
        content = @content.strip

        MarkdownUI::MenuTag.new(content, klass).render
      end
    end
  end
end
