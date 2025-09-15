module MarkdownUI
  module Renderers
    module Shape
      def shape(content)
        html do
          "<div class='ui shape'>#{content}</div>"
        end
      end
    end
  end
end