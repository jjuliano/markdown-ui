# coding: UTF-8

module MarkdownUI::Input
  class Custom
    def initialize(element, content, klass = nil, _id = nil)
      @element = element
      @klass   = klass
      @content = content
      @id      = _id
    end

    def render
      # Parse the klass parameter to extract modifiers and values
      element_parts = []
      modifier_map = {}

      # Parse klass like "icon search" or "labeled http://" into modifier => value pairs
      if @klass
        klass_parts = @klass.split
        i = 0
        while i < klass_parts.length
          modifier = klass_parts[i]
          # Check if next part exists and doesn't look like another modifier
          if i + 1 < klass_parts.length && !is_modifier?(klass_parts[i + 1])
            modifier_map[modifier] = klass_parts[i + 1]
            i += 2
          else
            modifier_map[modifier] = nil
            i += 1
          end
        end
      end

      # Add all modifiers to element_parts
      element_parts = modifier_map.keys

      # Remove 'input' from element to avoid duplication
      element_parts.delete('input')
      element_parts.delete('Input')
      element_parts = element_parts.compact.reject(&:empty?)

      # Build the wrapper class with element options
      wrapper_classes = ["ui"]
      wrapper_classes += element_parts
      wrapper_classes << "input"
      # Remove duplicates and clean up
      wrapper_klass = wrapper_classes.reject(&:empty?).uniq.join(' ').squeeze(' ').strip

      # Create the input element with placeholder
      placeholder = @content ? @content.strip : ""

      # Build the input tag with attributes
      if element_parts.include?('disabled')
        input_html = "<input type=\"text\" placeholder=\"#{placeholder}\" disabled />"
      else
        input_html = "<input type=\"text\" placeholder=\"#{placeholder}\" />"
      end

      # Handle icon inputs
      if element_parts.include?('icon')
        icon_name = modifier_map['icon'] || 'search'
        icon_html = "<i class=\"#{icon_name} icon\"></i>"
        input_html += icon_html
      end

      # Handle labeled inputs
      if element_parts.include?('labeled')
        label_text = modifier_map['labeled'] || ""
        label_html = "<div class=\"ui label\">#{label_text}</div>"
        input_html = "#{label_html}#{input_html}"
      end

      "<div class=\"#{wrapper_klass}\">#{input_html}</div>"
    end

    private

    def is_modifier?(word)
      # Common modifiers that don't take values
      %w[disabled error focus loading transparent fluid inverted].include?(word)
    end
  end
end
