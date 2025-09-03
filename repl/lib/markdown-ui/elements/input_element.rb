# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for input UI elements
    class InputElement < BaseElement
      
      def render
        input_type = determine_input_type
        placeholder = extract_placeholder
        value = extract_value

        result = build_input_html(input_type, placeholder, value)
        result.end_with?("\n") ? result : result + "\n"
      end
      
      private
      
      def determine_input_type
        # Check modifiers for input type
        input_types = %w[text password email number search url tel date time checkbox radio]
        found_type = @modifiers.find { |mod| input_types.include?(mod) }
        found_type || 'text'
      end
      
      def extract_placeholder
        case @content
        when Array
          # Check each content item for labeled syntax
          @content.each do |item|
            item_str = item.to_s.strip
            if item_str.start_with?('labeled ')
              # Found labeled syntax: extract modifier and label text
              item_str.sub(/^labeled\s+/, '')
              @modifiers << 'labeled' unless @modifiers.include?('labeled')
              return ''  # Return empty since we found labeled syntax
            end
          end

          # If no labeled syntax found, use first non-empty item
          @content.find { |item| !item.to_s.strip.empty? }&.to_s&.strip
        when String
          # Handle pipe-separated syntax like "placeholder|labeled label_text"
          if @content.include?('|')
            parts = @content.split('|')
            if parts.length >= 2
              # Check if any part contains "labeled "
              labeled_part_index = parts.find_index { |part| part.strip.start_with?('labeled ') }
              if labeled_part_index
                # Found labeled syntax in one of the parts
                @modifiers << 'labeled' unless @modifiers.include?('labeled')
                # Return the first non-labeled part as placeholder
                placeholder_part = parts.reject.with_index { |part, index| index == labeled_part_index }.first
                return placeholder_part ? placeholder_part.strip : ''
              else
                # No labeled part, just return first part
                return parts.first.strip
              end
            else
              return @content.strip
            end
          end

          if @content.start_with?('labeled ')
            # Handle labeled syntax in string content
            @modifiers << 'labeled' unless @modifiers.include?('labeled')
            ''  # Return empty since we found labeled syntax
          else
            @content.strip
          end
        else
          ''
        end
      end
      
      def extract_value
        # Check if there's a value specified in content like "Value:something"
        content_str = @content.is_a?(Array) ? @content.join(' ') : @content.to_s
        if content_str.include?('Value:')
          content_str.sub(/.*Value:/, '').strip
        else
          ''
        end
      end

      def extract_icon
        # Check for icon modifiers
        icon_modifier = @modifiers.find { |mod| mod.start_with?('icon ') }
        if icon_modifier
          icon_modifier.sub(/^icon\s+/, '').strip
        else
          nil
        end
      end

      def extract_actual_placeholder
        case @content
        when String
          if @content.include?('|')
            parts = @content.split('|')
            # Return the first part that's not the labeled part
            parts.find { |part| !part.strip.start_with?('labeled ') }&.strip || ''
          else
            @content.strip
          end
        when Array
          @content.find { |item| !item.to_s.strip.start_with?('labeled ') }&.to_s&.strip || ''
        else
          ''
        end
      end

      def extract_label_text
        case @content
        when String
          if @content.include?('|')
            parts = @content.split('|')
            labeled_part = parts.find { |part| part.strip.start_with?('labeled ') }
            if labeled_part
              labeled_part.strip.sub(/^labeled\s+/, '')
            else
              ''
            end
          else
            ''
          end
        when Array
          labeled_item = @content.find { |item| item.to_s.strip.start_with?('labeled ') }
          if labeled_item
            labeled_item.to_s.strip.sub(/^labeled\s+/, '')
          else
            ''
          end
        else
          ''
        end
      end
      
      def build_input_html(input_type, placeholder, value)
        # Special handling for action inputs
        if has_modifier?('action')
          return build_action_input_html(input_type)
        end

        icon_name = extract_icon

        attrs = []
        attrs << %[type="#{input_type}"]
        attrs << %[placeholder="#{escape_html(placeholder)}"] unless placeholder.empty?
        attrs << %[value="#{escape_html(value)}"] unless value.empty?

        # Handle state attributes
        state_modifiers = %w[disabled readonly required]
        state_modifiers.each do |state|
          if has_modifier?(state)
            attrs << state
          end
        end

        # Add CSS classes (excluding input type but keeping state modifiers as classes)
        classes = ['ui']
        # Filter out input types and handle special cases
        filtered_modifiers = @modifiers - [input_type]
        # Don't add 'transparent' as id, add it as class
        if filtered_modifiers.include?('transparent')
          classes << 'transparent'
          filtered_modifiers -= ['transparent']
        end
        # Filter out icon modifiers (they're used for the icon element, not CSS classes)
        filtered_modifiers = filtered_modifiers.reject { |mod| mod.start_with?('icon ') }
        classes.concat(filtered_modifiers)

        # Add 'input' class
        classes << 'input'

        # Add custom classes from attributes
        if @attributes && @attributes['class']
          custom_classes = Array(@attributes['class'])
          classes.concat(custom_classes)
        end

        # Add 'icon' class if there's an icon present (should come before 'input')
        classes.insert(-2, 'icon') if icon_name

        # Handle labeled inputs
        if has_modifier?('labeled')
          # Extract both placeholder and label text
          actual_placeholder = extract_actual_placeholder
          label_text = extract_label_text

          # Create labeled structure
          return "<div class=\"#{classes.join(' ')}\"#{html_attributes}>\n  <div class=\"ui label\">#{escape_html(label_text)}</div>\n  <input #{attrs.reject { |attr| attr.start_with?('placeholder=') }.reject(&:empty?).join(' ')} #{actual_placeholder.empty? ? '' : %[placeholder="#{escape_html(actual_placeholder)}"]} />\n</div>"
        end

        if ['checkbox', 'radio'].include?(input_type)
          # For checkbox/radio, wrap in a different structure
          if icon_name
            return "<div class=\"#{classes.join(' ')}\"#{html_attributes}>\n  <input #{attrs.reject(&:empty?).join(' ')} />\n  <i class=\"#{icon_name} icon\"></i>\n</div>"
          else
            return "<div class=\"#{classes.join(' ')}\"#{html_attributes}>\n  <input #{attrs.reject(&:empty?).join(' ')} />\n</div>"
          end
        else
          if icon_name
            return "<div class=\"#{classes.join(' ')}\"#{html_attributes}>\n  <input #{attrs.reject(&:empty?).join(' ')} />\n  <i class=\"#{icon_name} icon\"></i>\n</div>"
          else
            return "<div class=\"#{classes.join(' ')}\"#{html_attributes}>\n  <input #{attrs.reject(&:empty?).join(' ')} />\n</div>"
          end
        end
      end

      def build_action_input_html(input_type)
        # Parse content for action input components
        icon_html = ''
        input_html = ''
        button_html = ''

        if @content.is_a?(Array)
          @content.each do |content_item|
            content_str = content_item.to_s.strip
            if content_str.start_with?('_') && content_str.end_with?('_') && !content_str.start_with?('__')
              # Icon element (single underscores, e.g., _Search Icon_)
              icon_name = content_str[1..-2].strip.downcase
              # Don't add "icon" class if it's already in the name
              icon_class = icon_name.include?(' icon') ? icon_name : "#{icon_name} icon"
              icon_html = %[<i class="#{icon_class}"></i>\n  ] unless icon_name.empty?
            elsif content_str.start_with?('__') && content_str.end_with?('__')
              # Other UI elements (double underscores, e.g., __Input|Text|Order #__)
              inner_content = content_str[2..-3] # Remove __ __
              if inner_content.include?('|')
                parts = inner_content.split('|')
                element_type = parts[0]&.strip&.downcase
                if element_type == 'input'
                  # Parse input element
                  input_attrs = []
                  input_attrs << %[type="#{input_type}"]
                  # Handle different formats: Input|Placeholder or Input|Type|Placeholder
                  if parts.length >= 2
                    if parts.length == 2
                      # Format: Input|Placeholder
                      input_attrs << %[placeholder="#{escape_html(parts[1].strip)}"]
                    else
                      # Format: Input|Type|Placeholder
                      input_attrs << %[placeholder="#{escape_html(parts[2].strip)}"]
                    end
                  end
                  input_html = %[<input #{input_attrs.join(' ')} class="ui input" />\n  ]
                elsif element_type.include?('button')
                  # Parse button element
                  button_text = parts.length > 1 ? parts[1].strip : ''
                  button_classes = ['ui']
                  # Parse modifiers from element_type (e.g., "blue submit button" -> ["blue", "submit"])
                  button_modifiers = element_type.split(/\s+/)[0..-2] || [] # Exclude "button" from modifiers
                  button_classes.concat(button_modifiers)
                  button_classes << 'button' unless button_classes.include?('button')
                  button_html = %[<button class="#{button_classes.join(' ')}">#{escape_html(button_text)}</button>\n  ]
                end
              end
            end
          end
        end

        # Build the action input container
        classes = ['ui']
        filtered_modifiers = @modifiers - [input_type]
        filtered_modifiers = filtered_modifiers.reject { |mod| mod.start_with?('icon ') }
        classes.concat(filtered_modifiers)
        classes << 'input'

        %[<div class="#{classes.join(' ')}">\n  #{icon_html}#{input_html}#{button_html}</div>]
      end

      def element_name
        'input'
      end
    end
  end
end