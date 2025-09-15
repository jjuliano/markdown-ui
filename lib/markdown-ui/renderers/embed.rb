module MarkdownUI
  module Renderers
    module Embed
      def embed(content)
        html do
          "<div class='ui embed'>#{content}</div>"
        end
      end
    end
  end
end