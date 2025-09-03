module MarkdownUI
  module Renderers
    module BlockQuote
      def block_quote(text)
        element, content = text.split(':', 2)  # limit to 2 parts to handle URLs with colons
        @params          = element.split

        @elements = Hash.new(MarkdownUI::Content::BasicBlock).merge(
            button:    MarkdownUI::Button::Element,
            segment:   MarkdownUI::Segment,
            grid:      MarkdownUI::Grid::Grid,
            row:       MarkdownUI::Grid::Row,
            column:    MarkdownUI::Grid::Column,
            container: MarkdownUI::Container::Element,
            buttons:   MarkdownUI::Button::Group::Buttons::Element,
            label:     MarkdownUI::Label::Element,
            span:      MarkdownUI::Content::SpanBlock,
            content:   MarkdownUI::Content::ContentBlock,
            divider:   MarkdownUI::Content::DividerBlock,
            field:     MarkdownUI::Content::FieldBlock,
            fields:    MarkdownUI::Content::FieldsBlock,
            form:      MarkdownUI::Content::FormBlock,
            item:      MarkdownUI::Content::ItemBlock,
            tag:       MarkdownUI::Tag,
            menu:      MarkdownUI::Menu::Element,
            message:   MarkdownUI::Message::Element,
            input:     MarkdownUI::Content::InputBlock,
            header:    MarkdownUI::Content::HeaderBlock,
            card:      MarkdownUI::Content::CardBlock,
            comment:   MarkdownUI::Content::CommentBlock,
            modal:     MarkdownUI::Content::ModalBlock,
            accordion: MarkdownUI::Content::AccordionBlock
        )

        # For ItemBlock, Message, Modal, Segment, Accordion, Menu, Dropdown, Form, Card, Comment, and Container, don't use HTMLFormatter to avoid parsing issues
        if [:item, :message, :modal, :segment, :accordion, :menu, :dropdown, :form, :card, :comment, :container].include?(key)
          @elements[key].new(element, content).render
        else
          html { @elements[key].new(element, content).render } if content
        end
      end

      protected

      def regexp
        Regexp.new (@params.collect { |u| u.downcase }).join('|'), "i"
      end

      def key
        matching_keys = keys.grep(regexp)
        # Prioritize menu if it's in the matching keys
        menu_key = matching_keys.find { |k| k == :menu }
        menu_key || matching_keys.first
      end

      def keys
        @elements.keys
      end
    end
  end
end
