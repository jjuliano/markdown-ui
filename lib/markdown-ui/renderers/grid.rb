module MarkdownUI
  module Renderers
    module Grid
      def grid(text)
        html { "<article class='ui grid'>#{text}</article>" }
      end
    end
  end
end