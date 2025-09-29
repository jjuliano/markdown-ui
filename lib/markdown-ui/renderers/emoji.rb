module MarkdownUI
  module Renderers
    module Emoji
      def emoji(text)
        html { "<i class='ui emoji'>#{text}</i>" }
      end
    end
  end
end