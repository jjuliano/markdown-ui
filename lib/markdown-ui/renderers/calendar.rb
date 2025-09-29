module MarkdownUI
  module Renderers
    module Calendar
      def calendar(text)
        html { "<div class='ui calendar'>#{text}</div>" }
      end
    end
  end
end