module MarkdownUI
  module Renderers
    module BlockQuote
      def block_quote(text)
        element, content = text.split(':')
        @params          = element.split

        @elements = Hash.new(MarkdownUI::Content::BasicBlock).merge(
            button:    MarkdownUI::Button::Element,
            segment:   MarkdownUI::Segment,
            grid:      MarkdownUI::Grid,
            column:    MarkdownUI::Column,
            container: MarkdownUI::Container::Element,
            buttons:   MarkdownUI::Button::Group::Buttons::Element,
            label:     MarkdownUI::Label::Element,
            span:      MarkdownUI::Content::SpanBlock,
            content:   MarkdownUI::Content::ContentBlock,
            divider:   MarkdownUI::Content::DividerBlock,
            field:     MarkdownUI::Content::FieldBlock,
            form:      MarkdownUI::Content::FormBlock,
            item:      MarkdownUI::Content::ItemBlock,
            menu:      MarkdownUI::Menu::Element,
            message:   MarkdownUI::Message::Element,
            input:     MarkdownUI::Content::InputBlock,
            header:    MarkdownUI::Content::HeaderBlock
        )

        html { @elements[key].new(element, content).render } if content
      end

      protected

      def regexp
        Regexp.new (@params.collect { |u| u.downcase }).join('|'), "i"
      end

      def key
        keys.grep(regexp).first
      end

      def keys
        @elements.keys
      end
    end
  end
end
