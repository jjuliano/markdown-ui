module MarkdownUI
  module Renderers
    module Comment
      def comment(content)
        html do
          "<div class='ui comments'>#{content}</div>"
        end
      end
    end
  end
end