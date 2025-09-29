module MarkdownUI
  module Renderers
    module DropdownItem
      def dropdown_item(text)
        html { "<div class='item'>#{text}</div>" }
      end
    end
  end
end
