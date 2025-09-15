module MarkdownUI
  module Renderers
    module Placeholder
      def placeholder(content)
        html do
          "<div class='ui placeholder'>#{content}</div>"
        end
      end
    end
  end
end