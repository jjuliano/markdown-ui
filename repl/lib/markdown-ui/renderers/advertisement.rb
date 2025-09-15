module MarkdownUI
  module Renderers
    module Advertisement
      def advertisement(content)
        html do
          "<div class='ui advertisement'>#{content}</div>"
        end
      end
    end
  end
end