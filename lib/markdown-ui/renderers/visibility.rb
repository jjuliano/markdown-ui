module MarkdownUI
  module Renderers
    module Visibility
      def visibility(text)
        html { "<div class='ui visibility'>#{text}</div>" }
      end
    end
  end
end