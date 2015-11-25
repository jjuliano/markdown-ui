module MarkdownUI
  module Renderers
    module DoubleEmphasis
      def double_emphasis(text)
        @text = text

        html do
          case combined_elements
            when /button/i
              render_button
            when /input/i
              render_input
            when /menu/i
              render_menu
            when /message/i
              render_message
            when /tag/i
              render_tag
            when /header/i
              render_header
          end if content
        end
      end

      protected

      def render_header
        MarkdownUI::Header.new(content, 0).render
      end

      def render_tag
        MarkdownUI::Tag.new(first_element, content, _id, data_attributes).render
      end

      def first_element
        element[0].downcase
      end

      def render_message
        MarkdownUI::Message::Element.new(element, content, klass).render
      end

      def render_menu
        MarkdownUI::Menu::Element.new(element, content, klass).render
      end

      def render_input
        MarkdownUI::Input::Element.new(element, content, klass, _id).render
      end

      def render_button
        MarkdownUI::Button::Element.new(element, content, klass, _id).render
      end

      def data_attributes
        !args[3].nil? ? args[3].downcase : nil
      end

      def _id
        !args[2].nil? ? args[2].downcase : nil
      end

      def klass
        if args.is_a? Array
          if args[0].strip =~ /\./
            k = args[0].split('.')
            k.reverse!
            k.shift
          end
        end
      end

      def content
        if args.is_a? Array
          if args[1].strip =~ /\,/
            args[1].split(',')
          else
            args[1].strip
          end if !args[1].nil?
        end
      end

      def element
        args[0].split(' ') if args.is_a? Array
      end

      def args
        @text.split('|') if @text
      end

      def combined_elements
        element.join(' ')
      end
    end
  end
end

