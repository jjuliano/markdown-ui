# coding: UTF-8

module MarkdownUI
  class LabeledIconButton
    def initialize(icon, label, klass = nil)
      @klass = klass
      @icon = icon
      @label = label
    end

    def render
      icon = MarkdownUI::Content::Parser.new(@icon).parse
      label = MarkdownUI::Content::Parser.new(@label).parse
      klass = "ui #{@klass} labeled icon button"

      content = []
      content << icon
      content << label

      MarkdownUI::StandardTag.new(content.join, klass).render
    end
  end
end