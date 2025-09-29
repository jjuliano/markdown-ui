module MarkdownUI
  module Renderers
    module Nag
      def nag(text)
        html { "<div class='ui nag'>#{text}</div>" }
      end
    end
  end
end