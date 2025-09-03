module MarkdownUI
  module Button
    class Element
      def initialize(element, content, klass = nil, _id = nil)
        @element = element
        @content = content
        @klass   = klass
        @id      = _id
      end

      def render
        _id = nil

        # Handle the case where @element is the full text from double_emphasis
        if @element.is_a?(String) && @element.include?('|')
          # Parse the full text: "Element|Content|ID"
          parts = @element.split('|')
          element_type = parts[0]
          button_content = parts[1] if parts[1]
          button_class_or_id = parts[2] if parts[2]

          element = element_type.split(' ')
          content = button_content

          # If there's a third part, determine if it's a class or ID
          if button_class_or_id
            # Common Semantic UI button classes
            ui_classes = ['primary', 'secondary', 'positive', 'negative', 'red', 'orange', 'yellow', 'olive', 'green', 'teal', 'blue', 'violet', 'purple', 'pink', 'brown', 'grey', 'black', 'basic', 'inverted', 'compact', 'fluid', 'circular', 'loading', 'disabled']
            if ui_classes.include?(button_class_or_id.downcase)
              element << button_class_or_id.downcase
            else
              # Convert to proper ID format (lowercase, spaces to hyphens)
              _id = button_class_or_id.downcase.gsub(' ', '-')
            end
          end
        else
          element = if @element.is_a? Array
                      @element
                    else
                      @element.split(' ')
                    end
          content = @content
        end

        # Check if content contains icon/text format
        has_icon_text_format = content.is_a?(String) && content.include?('Icon:') && content.include?('Text:')

        animated_check = element.grep(/animated/i).any?
        mode = OpenStruct.new(
            :icon?      => element.grep(/icon/i).any? || has_icon_text_format,
            :flag?      => element.grep(/flag/i).any?,
            :image?     => element.grep(/image/i).any?,
            :focusable? => element.grep(/focusable/i).any?,
            :animated?  => animated_check,
            :labeled?   => element.grep(/labeled/i).any? || has_icon_text_format,
            :basic?     => element.grep(/basic/i).any?,
            :toggle?    => element.grep(/toggle/i).any?
        )

        klass = if @klass.nil?
                  # For animated buttons, construct the proper class name
                  if mode.animated?
                    # Find animation type (skip generic "animated" and "button")
                    animation_type = nil
                    modifiers = []

                    element.each do |e|
                      next if e.downcase == 'animated' || e.downcase == 'button'
                      if ['fade', 'vertical', 'horizontal'].include?(e.downcase)
                        animation_type = e.downcase
                      else
                        modifiers << e.downcase
                      end
                    end

                    if animation_type
                      "ui #{animation_type} animated #{modifiers.join(' ')} button".strip
                    else
                      "ui animated #{modifiers.join(' ')} button".strip
                    end
                  else
                    "ui #{element.join(' ').strip.downcase}"
                  end
                else
                  @klass
                end

        _id = _id || @id

        if content
          # Check special modes first (animated, focusable, basic, toggle)
          if mode.animated?
            return MarkdownUI::Button::Animated.new(content, klass, _id).render
          elsif mode.focusable?
            return MarkdownUI::Button::Focusable.new(content, klass, _id).render
          elsif mode.basic?
            return MarkdownUI::Button::Basic.new(content, klass, _id).render
          elsif mode.toggle?
            return MarkdownUI::Button::Toggle.new(content, klass, _id).render
          elsif mode.icon? && mode.labeled?
            # Parse content like "Icon:Pause,Text:Pause" into separate icon and label
            if content.is_a?(String)
              # Split on comma and parse each part
              parts = content.split(',')
              icon_part = parts.find { |p| p.strip.start_with?('Icon:') }
              label_part = parts.find { |p| p.strip.start_with?('Text:') }

              icon = icon_part ? icon_part.strip.sub('Icon:', '') : ''
              label = label_part ? label_part.strip.sub('Text:', '') : ''
            else
              # Handle array content
              icon, label = content
            end
            return MarkdownUI::Button::LabeledIcon.new(icon, label, klass, _id).render
          elsif mode.icon? && !mode.labeled?
            # Parse content like "Icon:Pause, Pause" to extract just the icon name
            if content.is_a?(String) && content.include?('Icon:')
              icon_name = content.split(',')[0].strip.sub('Icon:', '')
              return MarkdownUI::Button::Icon.new(icon_name, klass, _id).render
            else
              return MarkdownUI::Button::Icon.new(content, klass, _id).render
            end
          elsif standard_button?(mode)
            return MarkdownUI::Button::Standard.new(content, klass, _id).render
          else
            # For non-standard buttons with multiple classes
            return MarkdownUI::Button::Custom.new(element, content, klass, _id).render
          end
        else
          return MarkdownUI::Button::Custom.new(element, '', klass, _id).render
        end
      end

      protected

      def standard_button?(mode)
        !mode.focusable? && !mode.animated? && !mode.icon? && !mode.labeled? && !mode.basic? && !mode.toggle?
      end

    end
  end
end
