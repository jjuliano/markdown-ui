# coding: UTF-8

module MarkdownUI
  module Content
    class Text
      def initialize(content, klass = nil)
        @content = content
        @klass = klass
      end

      def render
        content = @content.strip

        if @klass
          klass = @klass.squeeze(' ').strip

          "<div class=\"#{klass.downcase}\">#{content}</div>"
        else
        "#{content}"
        end
      end
    end
  end
end