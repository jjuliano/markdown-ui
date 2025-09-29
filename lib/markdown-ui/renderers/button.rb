module MarkdownUI
  module Renderers
    module Button
      def button(text)
        html { "<button class='ui button'>#{text}</button>" }
      end
    end
  end
end
