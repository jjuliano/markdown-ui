module MarkdownUI
  module Renderers
    module Feed
      def feed(content)
        html do
          "<div class='ui feed'>#{content}</div>"
        end
      end
    end
  end
end