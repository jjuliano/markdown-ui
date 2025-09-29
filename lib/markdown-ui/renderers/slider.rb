module MarkdownUI
  module Renderers
    module Slider
      def slider(text)
        html { "<div class='ui slider'>#{text}</div>" }
      end
    end
  end
end