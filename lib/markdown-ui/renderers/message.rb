module MarkdownUI
  module Renderers
    module Message
      def message(text)
        html { "<div class='ui message'>#{text}</div>" }
      end
    end
  end
end
