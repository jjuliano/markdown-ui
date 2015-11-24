module MarkdownUI
  module Renderers
    module List
      def list(content, list_type)
        klass = "ui #{list_type}"
        html { MarkdownUI::Content::List.new(content, klass, list_type).render }
      end
    end
  end
end
