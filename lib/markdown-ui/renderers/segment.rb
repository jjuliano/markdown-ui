module MarkdownUI
  module Renderers
    module Segment
      def segment(text)
        html { "<div class='ui segment'>#{text}</div>" }
      end
    end
  end
end
