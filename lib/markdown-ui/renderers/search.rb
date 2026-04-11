module MarkdownUI
  module Renderers
    module Search
      def search(content)
        html do
          "<div class='ui search'>#{content}</div>"
        end
      end
    end
  end
end