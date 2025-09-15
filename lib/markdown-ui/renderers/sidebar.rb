module MarkdownUI
  module Renderers
    module Sidebar
      def sidebar(content)
        html do
          "<div class='ui sidebar'>#{content}</div>"
        end
      end
    end
  end
end