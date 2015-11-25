# coding: UTF-8

module MarkdownUI
  module Content
    class Custom
      def initialize(content, klass = nil)
        @content = content
        @klass   = klass
      end

      def render
        @content.strip
      end
    end
  end
end
