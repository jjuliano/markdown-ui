module MarkdownUI
  module Renderers
    module Label
      def label(text)
        html { "<label class='ui label'>#{text}</label>" }
      end
    end
  end
end