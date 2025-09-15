module MarkdownUI
  module Renderers
    module Sticky
      def sticky(content)
        html do
          "<div class='ui sticky'>#{content}</div>"
        end
      end
    end
  end
end