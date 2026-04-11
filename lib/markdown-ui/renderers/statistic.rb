module MarkdownUI
  module Renderers
    module Statistic
      def statistic(content)
        html do
          "<div class='ui statistics'>#{content}</div>"
        end
      end
    end
  end
end