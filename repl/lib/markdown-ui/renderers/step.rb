module MarkdownUI
  module Renderers
    module Step
      def step(content)
        html do
          "<div class='ui steps'>#{content}</div>"
        end
      end
    end
  end
end