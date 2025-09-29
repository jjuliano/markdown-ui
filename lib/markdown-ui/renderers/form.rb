module MarkdownUI
  module Renderers
    module Form
      def form(text)
        html { "<form class='ui form'>#{text}</form>" }
      end
    end
  end
end
