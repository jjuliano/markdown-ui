module MarkdownUI
  module Renderers
    module Input
      def input(text)
        html { "<div class='ui input'><input type='text' placeholder='#{text}' /></div>" }
      end
    end
  end
end
