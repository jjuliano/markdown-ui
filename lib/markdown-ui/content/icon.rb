# coding: UTF-8

module MarkdownUI
  module Content
    class Icon
      def initialize(content, klass = nil)
        @content = content.downcase
        @klass = klass.downcase if klass
      end

      def render
        klass = "#{@content} #{@klass} icon".squeeze(' ').strip

        "<i class=\"#{klass}\"></i>"
      end
    end
  end
end