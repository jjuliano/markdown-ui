module MarkdownUI
  module Menu
    class Element < MarkdownUI::Shared::TagKlass
      def initialize(_element, _content, _klass = nil)
        @elements = Hash.new(MarkdownUI::Menu::Standard).merge(
            item:        MarkdownUI::Menu::Item,
            secondary:   MarkdownUI::Menu::Secondary,
            pagination:  MarkdownUI::Menu::Pagination,
            pointing:    MarkdownUI::Menu::Pointing,
            tabular:     MarkdownUI::Menu::Tabular,
            text:        MarkdownUI::Menu::Text,
            vertical:    MarkdownUI::Menu::Vertical
        )

        @element  = _element
        @content  = _content
        @klass    = "#{_klass} #{element}"
      end

      def key
        # For menu elements, prioritize 'menu' key
        element_str = @element.is_a?(Array) ? @element.join(' ') : @element.to_s
        if element_str && element_str.downcase.include?('menu')
          :menu
        else
          super
        end
      end

      def render
        @params = element.split

        if content
          @elements[key].new(content, klass_text).render
        else
          ""
        end
      end
    end
  end
end
