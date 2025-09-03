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
        # Create the icon and label HTML directly
        icon_html  = "<i class=\"#{@icon.downcase} icon\"></i>"
        label_html = @label
        klass = "ui #{@klass} labeled icon button"
        _id   = @id

        content = icon_html + label_html

        MarkdownUI::ButtonTag.new(content, klass, _id).render
      end
    end
  end
end
