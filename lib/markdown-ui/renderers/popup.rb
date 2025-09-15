module MarkdownUI
  module Renderers
    module Popup
      def popup(content)
        html do
          "<div class='ui popup'>#{content}</div>"
        end
      end
    end
  end
end