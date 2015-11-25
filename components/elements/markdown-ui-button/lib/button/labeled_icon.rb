# coding: UTF-8

module MarkdownUI
  module Button
    class LabeledIcon
      def initialize(icon, label, klass = nil, _id = nil)
        @klass = klass
        @icon  = icon
        @label = label
        @id    = _id
      end

      def render
        icon  = MarkdownUI::Content::Parser.new(@icon).parse
        label = MarkdownUI::Content::Parser.new(@label).parse
        klass = "ui #{@klass} labeled icon button"
        _id   = @id

        content = []
        content << icon
        content << label

        MarkdownUI::ButtonTag.new(content.join, klass, _id).render
      end
    end
  end
end
