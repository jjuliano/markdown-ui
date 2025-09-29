module MarkdownUI
  module Renderers
    module Container
      def container(text)
        html { "<div class='ui container'>#{text}</div>" }
      end
    end
  end
end
