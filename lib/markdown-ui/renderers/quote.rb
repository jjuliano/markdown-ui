module MarkdownUI
  module Renderers
    module Quote
      def quote(text)
        html { "<p>#{text}</p>" }
      end
    end
  end
end
