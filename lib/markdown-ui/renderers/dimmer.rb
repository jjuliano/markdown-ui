module MarkdownUI
  module Renderers
    module Dimmer
      def dimmer(content)
        html do
          "<div class='ui dimmer'>#{content}</div>"
        end
      end
    end
  end
end