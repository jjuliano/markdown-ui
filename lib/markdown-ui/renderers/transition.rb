module MarkdownUI
  module Renderers
    module Transition
      def transition(content)
        html do
          "<div class='ui transition'>#{content}</div>"
        end
      end
    end
  end
end