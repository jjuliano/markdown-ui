module MarkdownUI
  module Renderers
    module Rail
      def rail(content)
        html do
          "<div class='ui rail'>#{content}</div>"
        end
      end
    end
  end
end