module MarkdownUI
  module Renderers
    module Rating
      def rating(content)
        html do
          "<div class='ui rating'>#{content}</div>"
        end
      end
    end
  end
end