# coding: UTF-8

module MarkdownUI
  module Content
    class List
      def initialize(content, klass = nil, type = nil, data = nil)
        @content = content
        @klass = klass
        @type = type
        @data = data
      end

      def render
        klass = "#{@klass} list"
        content = @content.strip
        type = @type
        data = @data

        MarkdownUI::ListTag.new(content, klass, type, data).render
      end
    end
  end
end