module MarkdownUI
  module Renderers
    module Field
      def field(text)
        html { "<div class='field'>#{text}</div>" }
      end
    end
  end
end
