# coding: UTF-8

module MarkdownUI
  module Content
    class Flag
      def initialize(content, klass = nil)
        @content = content
        @klass   = klass
      end

      def render
        content = @content.downcase
        klass   = MarkdownUI::KlassUtil.new("#{content} #{@klass} flag").klass

        output = []
        output << '<i'
        output << klass
        output << '></i>'

        output.join
      end
    end
  end
end
