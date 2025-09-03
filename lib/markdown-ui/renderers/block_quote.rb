module MarkdownUI
  module Renderers
    module BlockQuote
      def block_quote(text)
        element, content = text.split(':', 2)  # limit to 2 parts to handle URLs with colons
        @params          = element.split

        @elements = Hash.new(MarkdownUI::Content::BasicBlock).merge(
            # Original elements
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
            accordion: MarkdownUI::Content::AccordionBlock,

            # New Semantic UI 2.5.0 Elements
            reveal:    MarkdownUI::Components::Elements::RevealElement,
            loader:    MarkdownUI::Components::Elements::LoaderElement,
            flag:      MarkdownUI::Components::Elements::FlagElement,
            rail:      MarkdownUI::Components::Elements::RailElement,
            sidebar:   MarkdownUI::Components::Elements::SidebarElement,
            sticky:    MarkdownUI::Components::Elements::StickyElement,

            # New Collections
            breadcrumb: MarkdownUI::Components::Collections::BreadcrumbElement,
            table:     MarkdownUI::Components::Collections::TableElement,

            # New Views
            feed:      MarkdownUI::Components::Views::FeedElement,
            statistic: MarkdownUI::Components::Views::StatisticElement,
            advertisement: MarkdownUI::Components::Views::AdvertisementElement,

            # New Modules
            checkbox:  MarkdownUI::Components::Modules::CheckboxElement,
            dimmer:    MarkdownUI::Components::Modules::DimmerElement,
            embed:     MarkdownUI::Components::Modules::EmbedElement,
            rating:    MarkdownUI::Components::Modules::RatingElement,
            search:    MarkdownUI::Components::Modules::SearchElement,
            shape:     MarkdownUI::Components::Modules::ShapeElement,
            transition: MarkdownUI::Components::Modules::TransitionElement,

            # Additional Missing Elements from full coverage analysis
            step:      MarkdownUI::Components::Elements::StepElement,
            placeholder: MarkdownUI::Components::Elements::PlaceholderElement,
            popup:     MarkdownUI::Components::Modules::PopupElement,
            tab:       MarkdownUI::Components::Modules::TabElement
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

        # Prioritize exact matches first
        element_name = @params.join(' ').downcase
        exact_match = matching_keys.find { |k| k.to_s == element_name.gsub(' ', '') }
        return exact_match if exact_match

        # Prioritize menu if it's in the matching keys
        menu_key = matching_keys.find { |k| k == :menu }
        return menu_key if menu_key

        # For disambiguation, prefer longer/more specific matches
        matching_keys.max_by { |k| k.to_s.length } || matching_keys.first
      end

      def keys
        @elements.keys
      end
    end
  end
end
