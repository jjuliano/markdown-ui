module MarkdownUI
  module Renderers
    module State
      def state(text)
        html { "<div class='ui state'>#{text}</div>" }
      end
    end
  end
end