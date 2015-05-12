# coding: UTF-8

module MarkdownUI
  module Content
    class Header
      def initialize(content, klass = nil)
        @content = content
        @klass = klass.downcase if klass
      end

      def render
        klass = "#{@klass} header".downcase.split(" ").uniq

        "<div class=\"#{klass.join(" ").strip}\">#{@content.strip}</div>\n"
      end
    end
  end
end