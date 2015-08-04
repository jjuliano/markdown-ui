# coding: UTF-8

module MarkdownUI::Container
  module Alignment
    class Right
      def initialize(element, content)
        @element = element
        @content = content
      end

      def render
        klass = "ui #{@element} right aligned container"
        content = @content.strip

        MarkdownUI::StandardTag.new(content, klass).render
      end
    end
  end
end
