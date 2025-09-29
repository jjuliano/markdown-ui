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
            when /breadcrumb/i
              render_breadcrumb
            when /grid/i
              render_grid
            when /table/i
              render_table
            when /emoji/i
              render_emoji
            when /icon/i
              render_icon
            when /label/i
              render_label
            when /image/i
              render_image
            when /loader/i
              render_loader
            when /modal/i
              render_modal
            when /progress/i
              render_progress
            when /text/i
              render_text
            when /calendar/i
              render_calendar
            when /flyout/i
              render_flyout
            when /nag/i
              render_nag
            when /slider/i
              render_slider
            when /toast/i
              render_toast
          end if !content.nil?
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

      def render_breadcrumb
        "<nav class='ui breadcrumb'>#{content}</nav>"
      end

      def render_grid
        "<article class='ui grid'>#{content}</article>"
      end

      def render_table
        classes = element.join(' ')
        table_content = content.split('|').map { |cell| "<td>#{cell.strip}</td>" }.join('')
        "<table class='ui #{classes} table'>#{table_content}</table>"
      end

      def render_emoji
        "<i class='ui emoji emoji'>#{content}</i>"
      end

      def render_icon
        "<i class='ui #{content} icon'></i>"
      end

      def render_image
        # Handle custom image syntax: __Image: modifiers | alt | src__
        # For complex syntax, content has multiple parts separated by |
        all_parts = @text.split('|').map(&:strip)
        if all_parts.size >= 3 && all_parts[0].include?('Image')
          # Custom syntax: __Image: modifiers | alt | src__
          modifiers_part = all_parts[0]
          alt = all_parts[1]
          src = all_parts[2]

          # Extract modifiers from "Image: modifiers"
          modifiers = modifiers_part.sub(/^Image:\s*/, '').split
          classes = modifiers.join(' ')
          "<img class='ui #{classes} image' src='#{src}' alt='#{alt}'>"
        else
          # Simple syntax: __modifiers image|src__
          classes = element.reject { |c| c.downcase == 'image' }.join(' ')
          "<img class='ui #{classes} image' src='#{content}' alt='#{content}'>"
        end
      end

      def render_label
        classes = element.join(' ')
        "<label class='ui #{classes} label'>#{content}</label>"
      end

      def render_loader
        classes = element.join(' ')
        "<div class='ui #{classes} loader'>#{content}</div>"
      end

      def render_modal
        classes = element.join(' ')
        "<div class='ui #{classes} modal'>#{content}</div>"
      end

      def render_progress
        classes = element.join(' ')
        "<div class='ui #{classes} progress'>#{content}</div>"
      end

      def render_text
        classes = element.join(' ')
        "<span class='ui #{classes} text'>#{content}</span>"
      end

      def render_calendar
        classes = element.join(' ')
        "<div class='ui #{classes} calendar'>#{content}</div>"
      end

      def render_flyout
        "<div class='ui flyout'>#{content}</div>"
      end

      def render_nag
        "<div class='ui nag'>#{content}</div>"
      end

      def render_slider
        "<div class='ui slider'>#{content}</div>"
      end

      def render_toast
        classes = element.join(' ')
        "<div class='ui #{classes} toast'>#{content}</div>"
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
          if args.size > 1
            if args[1].strip =~ /\,/
              args[1].split(',')
            else
              content = args[1].strip
              content == '__' ? '' : content
            end
          else
            # Handle case where text ends with | but Redcarpet split it
            @text.include?('|') ? '' : nil
          end
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

