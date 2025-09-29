module MarkdownUI
  module Renderers
    module Flyout
      def flyout(text)
        html { "<div class='ui flyout'>#{text}</div>" }
      end
    end
  end
end