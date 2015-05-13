# coding: UTF-8

module MarkdownUI
  module Content
    class Text
      def initialize(content, klass = nil)
        @content = content
        @klass = klass
      end

      def render
        content = if @klass
          klass = "#{@klass}"

          MarkdownUI::StandardTag.new(@content, klass).render
        else
          "#{@content.strip}"
        end

        content
      end
    end
  end
end