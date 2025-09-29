module MarkdownUI
  module Renderers
    module Breadcrumb
      def breadcrumb(text)
        html { "<nav class='ui breadcrumb'>#{text}</nav>" }
      end
    end
  end
end