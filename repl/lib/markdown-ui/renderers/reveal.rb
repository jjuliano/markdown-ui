module MarkdownUI
  module Renderers
    module Reveal
      def reveal(content)
        html do
          "<div class='ui reveal'>#{content}</div>"
        end
      end
    end
  end
end