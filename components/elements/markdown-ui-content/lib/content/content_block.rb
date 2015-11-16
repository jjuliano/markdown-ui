# coding: UTF-8

module MarkdownUI
  module Content
    class ContentBlock
      def initialize(element, content)
        @element = element
        @content = content
      end

      def render
        klass = "ui #{@element} content"
        content = @content.strip

        MarkdownUI::StandardTag.new(content, klass).render
      end
    end
  end
end
