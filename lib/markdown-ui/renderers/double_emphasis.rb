module MarkdownUI
  module Renderers
    module DoubleEmphasis
      def double_emphasis(text)
        @text = text

        # For messages, menus, dropdowns, forms, cards, images, comments, loaders, and items, don't use HTML formatter to preserve compact formatting
        if combined_elements =~ /button/i
          return render_button
        elsif combined_elements =~ /message/i
          return render_message
        elsif combined_elements =~ /menu/i
          return render_menu
        elsif combined_elements =~ /dropdown/i
          return render_dropdown
        elsif combined_elements =~ /form/i
          return render_form
        elsif combined_elements =~ /card/i
          return render_card
        elsif combined_elements =~ /image/i
          return render_image
        elsif combined_elements =~ /comment/i
          return render_comment
        elsif combined_elements =~ /loader/i
          return render_loader
        elsif combined_elements =~ /item/i
          return render_item
        else
          result = html do
            case combined_elements
              when /input/i
                render_input
              when /field/i
                render_field
              when /div/i, /div tag/i
                render_div
              when /tag/i
                render_tag
              when /header/i
                render_header
              when /label/i
                render_label
              when /table/i
                render_table
              when /progress/i
                render_progress
              when /modal/i
                render_modal
              when /accordion/i
                render_accordion
            end if content || (combined_elements && ['loader'].include?(combined_elements.downcase))
          end
          return result if result
        end

        nil
      end

      protected

      def render_header
        MarkdownUI::Header.new(content, 0).render
      end

      def render_tag
        MarkdownUI::Tag.new(first_element, content, _id, data_attributes).render
      end

      def render_div
        # For __Div Tag|content|modifiers__, modifiers are in args[2]
        modifiers = args[2] ? args[2].split : []
        classes = []
        modifiers.each do |modifier|
          case modifier.downcase
          when 'label'
            classes << 'label'
          when 'teal'
            classes << 'teal'
          when 'pointing'
            classes << 'pointing'
          when 'left'
            classes << 'left'
          when 'right'
            classes << 'right'
          end
        end

        class_attr = classes.empty? ? '' : " class=\"#{classes.join(' ')}\""
        "<div#{class_attr}>#{content}</div>"
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

      def render_field
        MarkdownUI::Content::FieldBlock.new(element, content).render
      end

      def render_button
        # For buttons, pass the full text so the Button::Element can parse pipes correctly
        # Don't use HTML formatter for buttons to preserve compact formatting
        MarkdownUI::Button::Element.new(@text, nil, klass, _id).render
      end

      def render_image
        MarkdownUI::Image::Element.new(element, content, klass).render
      end

      def render_label
        # For labels, use args[2] as the class parameter
        label_klass = args[2] if args && args.length > 2
        MarkdownUI::Label::Element.new(element, content, label_klass).render
      end

      def render_loader
        MarkdownUI::Loader::Element.new(element, content, klass).render
      end

      def render_table
        # Tables need all args, not just parsed content
        table_args = args[1..-1] if args.length > 1
        MarkdownUI::Table::Element.new(element, table_args, klass).render
      end

      def render_progress
        MarkdownUI::Progress::Element.new(element, content, klass, _id, data_attributes).render
      end

      def render_dropdown
        # For Dropdown, we need to pass all args after the element name (like Card does)
        dropdown_content = args[1..-1].join('|') if args.length > 1
        MarkdownUI::Dropdown::Element.new(element, dropdown_content, klass, _id).render
      end

      def render_form
        MarkdownUI::Form::Element.new(element, content, klass).render
      end

      def render_card
        # For Card, we need to pass all args after the element name
        card_content = args[1..-1].join('|') if args.length > 1
        MarkdownUI::Card::Element.new(element, card_content, klass).render
      end

      def render_comment
        MarkdownUI::Comment::Element.new(element, content, klass).render
      end

      def render_item
        MarkdownUI::Item::Element.new(element, content, klass).render
      end

      def render_modal
        MarkdownUI::Content::ModalBlock.new(combined_elements, content).render
      end

      def render_accordion
        MarkdownUI::Content::AccordionBlock.new(combined_elements, content).render
      end

      def data_attributes
        !args[3].nil? ? args[3].downcase : nil
      end

      def _id
        # ID can be in args[2] or args[3] depending on the pattern
        # __Component|content|modifiers|id__ -> args[3]
        # __Component|content|id__ -> args[2]
        
        # For progress components, don't treat args[3] as an ID since it's usually options
        if first_element && first_element.downcase == 'progress'
          return nil
        end
        
        if !args[3].nil?
          # If args[3] exists, it's likely an ID
          args[3].downcase
        elsif !args[2].nil?
          # Check if args[2] looks like an ID (starts with letter/number/underscore/hyphen)
          # Convert spaces to hyphens for ID format
          # Don't treat numbers as IDs (they might be percentages for progress bars)
          # Don't treat component names as IDs (they might be percentages or modifiers)
          # Only treat as ID if it looks like a simple identifier (no hyphens from spaces)
          # and doesn't contain common modifier words
          potential_id = args[2].downcase
          if potential_id =~ /^[a-zA-Z][a-zA-Z0-9]*$/ &&  # No spaces, hyphens, or special chars
             potential_id !~ /^(ui|button|negative|positive|primary|secondary|compact|fluid|circular|loading|progress|message|segment|card|form|menu|dropdown|modal|accordion|table|input|label|image|header|div|tag|field|comment|item|loader|flag|icon|step|breadcrumb|grid|statistic|feed|disabled|error|focus|active|inverted|transparent|avatar|bordered|circular|rounded|fluid|mini|tiny|small|medium|large|big|huge|massive|centered|floated|left|right|hidden|spaced)$/i &&
             !potential_id.match?(/^\d+$/)
            potential_id
          else
            nil
          end
        else
          nil
        end
      end

      def klass
        if args.is_a? Array
          # For components like __Input|content|modifier value__, return args[2] if it exists
          # But only if args[2] is not being used as an ID
          if args.length > 2 && _id.nil?
            return args[2].gsub(/__*$/, '').strip
          end

          # Legacy support for dot notation
          if args[0].strip =~ /\./
            k = args[0].split('.')
            k.reverse!
            k.shift
            return k.join(' ') if k.any?
          end
        end
        nil
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

