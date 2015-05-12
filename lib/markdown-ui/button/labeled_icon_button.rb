# coding: UTF-8

module MarkdownUI
  class LabeledIconButton
    def initialize(icon, label, klass = nil)
      @klass = klass
      @icon = MarkdownUI::Content::Parser.new(icon).parse
      @label = MarkdownUI::Content::Parser.new(label).parse
    end

    def render
      klass = "ui #{@klass} labeled icon button"
      "<div class=\"#{klass.squeeze(' ').strip}\">#{@icon}#{@label}</div>\n"
    end
  end
end