module MarkdownUI
  module Renderers
    module Api
      def api(text)
        html { "<div class='ui api' data-api='#{text}'>#{text}</div>" }
      end
    end
  end
end