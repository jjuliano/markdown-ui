module MarkdownUI
  module Renderers
    module Header
      def header(text, level)
        html { MarkdownUI::Header.new(text, level).render }
      end
    end
  end
end
