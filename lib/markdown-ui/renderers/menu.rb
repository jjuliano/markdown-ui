module MarkdownUI
  module Renderers
    module Menu
      def menu(text)
        html { "<div class='ui menu'>#{text}</div>" }
      end
    end
  end
end
