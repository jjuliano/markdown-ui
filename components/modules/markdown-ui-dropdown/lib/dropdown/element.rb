module MarkdownUI::Dropdown
  class Element
    def initialize(element, content, klass = nil, _id = nil)
      @element = element
      @content = content
      @klass   = klass
      @id      = _id
    end

    def render
      element = if @element.is_a? Array
                  @element
                else
                  @element.split(' ')
                end

      # For dropdown, reconstruct the full content from parameters
      # The DoubleEmphasis renderer splits the content, so we need to combine it back
      if @content && @klass && @id
        # Combine all parameters: content|options|variations
        full_content = "#{@content}|#{@klass}|#{@id}"
      elsif @content && @klass
        # Combine content and klass back together for parsing
        full_content = "#{@content}|#{@klass}"
      else
        full_content = @content
      end

      klass = element.join(' ').strip.downcase

      MarkdownUI::Dropdown::Custom.new(element, full_content, klass).render
    end
  end
end