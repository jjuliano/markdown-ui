module MarkdownUI
  module Renderers
    module Tab
      def tab(content)
        html do
          "<div class='ui tabular menu'>#{content}</div>"
        end
      end
    end
  end
end