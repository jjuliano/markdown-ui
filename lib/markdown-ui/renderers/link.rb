module MarkdownUI
  module Renderers
    module Link
      def link(link, klass, content)
        _klass = "ui #{klass}"
        html { MarkdownUI::Content::Item.new(content, _klass, link).render }
      end
    end
  end
end
