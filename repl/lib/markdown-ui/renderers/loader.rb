module MarkdownUI
  module Renderers
    module Loader
      def loader(content)
        html do
          "<div class='ui loader'>#{content}</div>"
        end
      end
    end
  end
end