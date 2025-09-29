module MarkdownUI
  module Renderers
    module Divider
      def divider(text)
        html { "<div class='ui divider'>#{text}</div>" }
      end
    end
  end
end
