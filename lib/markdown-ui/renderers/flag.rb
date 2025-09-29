module MarkdownUI
  module Renderers
    module Flag
      def flag(text)
        html { "<i class='ui #{text} flag'></i>" }
      end
    end
  end
end
