# coding: UTF-8

module MarkdownUI
  module Content
    class Item
      def initialize(content, klass = nil, link = nil)
        @content = content
        @klass = klass
        @link = link
      end

      def render
        klass = "ui #{@klass} item"
        content = @content.strip
        link = @link

        MarkdownUI::ItemTag.new(content, klass, link).render
      end
    end
  end
end
