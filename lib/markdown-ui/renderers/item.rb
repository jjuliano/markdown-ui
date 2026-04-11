module MarkdownUI
  module Renderers
    module Item
      def item(content)
        html do
          "<div class='ui items'>#{content}</div>"
        end
      end
    end
  end
end