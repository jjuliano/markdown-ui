module MarkdownUI
  module Renderers
    module Icon
      def icon(text)
        html { "<i class='ui icon'>#{text}</i>" }
      end
    end
  end
end