module MarkdownUI
  module Renderers
    module Toast
      def toast(text)
        html { "<div class='ui toast'>#{text}</div>" }
      end
    end
  end
end