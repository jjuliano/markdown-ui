module MarkdownUI::Image
  class Element
    def initialize(element, content, klass = nil, alt_text = nil)
      @element = element
      @content = content
      @klass   = klass
      @alt_text = alt_text
    end

    def render
      # Handle the case where @element is an array from double_emphasis renderer
      element_name = @element.is_a?(Array) ? @element.first : @element

      # Debug: print what we're getting
      # puts "Image::Element DEBUG: element_name='#{element_name}', content='#{@content}', klass='#{@klass}'"

      # If element_name contains pipe, it means we're using the pipe-separated format
      if element_name.include?('|')
        parts = element_name.split('|')
        src_url = parts[1] if parts[1]
        additional_params = parts[2] if parts[2]

        element = []
        content = src_url || @content

        # If there's a third part, it could be alt text or additional classes
        if additional_params
          # Check if it's alt text (contains spaces or doesn't match common image classes)
          common_image_classes = ['circular', 'rounded', 'fluid', 'avatar', 'bordered', 'disabled', 'mini', 'tiny', 'small', 'medium', 'large', 'big', 'huge', 'massive', 'centered', 'floated', 'left', 'right', 'hidden', 'spaced']
          first_word = additional_params.split.first
          if additional_params.include?(' ') && !common_image_classes.include?(first_word)
            # This looks like alt text with spaces
            @alt_text = additional_params
          elsif additional_params.include?(' ')
            # Multiple classes separated by spaces
            element.concat(additional_params.split)
          else
            # Single class
            element << additional_params
          end
        end
      else
        # Standard case: element is ["Image"], content is src URL, klass contains the modifiers
        element = @element.is_a?(Array) ? @element : [@element]
        content = @content

        # Check if klass contains alt text (has spaces and first word is not a common class)
        common_image_classes = ['circular', 'rounded', 'fluid', 'avatar', 'bordered', 'disabled', 'mini', 'tiny', 'small', 'medium', 'large', 'big', 'huge', 'massive', 'centered', 'floated', 'left', 'right', 'hidden', 'spaced']
        if @klass && !@klass.empty?
          if @klass.include?(' ') && !common_image_classes.include?(@klass.split.first)
            # This looks like alt text
            @alt_text = @klass
          elsif @klass.include?(' ')
            # Multiple classes
            element.concat(@klass.split)
          else
            # Single class
            element << @klass
          end
        end
      end

      # Build the klass string - if we have modifiers in element array, use those
      # Otherwise use the original klass
      if element.length > 1
        # Element contains modifiers like ["Image", "circular"]
        klass = element.join(' ').strip
      else
        # No modifiers, just use the original klass or empty string
        klass = @klass || ''
      end
      MarkdownUI::Image::Custom.new(element, content, klass, @alt_text).render
    end
  end
end