# coding: UTF-8

module MarkdownUI
  module Content
    class Icon
      def initialize(content, klass = nil)
        @content = content
        @klass = klass
      end

      def render
        content = @content.downcase
        klass = MarkdownUI::KlassUtil.new("#{@content} #{@klass} icon").klass

        output = []
        output << "<i"
        output << klass
        output << "></i>"

        output.join
      end
    end
  end
end
