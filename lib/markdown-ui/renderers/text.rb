module MarkdownUI
  module Renderers
    module Text
      def text(content)
        html { "<span class='ui text'>#{content}</span>" }
      end
    end
  end
end