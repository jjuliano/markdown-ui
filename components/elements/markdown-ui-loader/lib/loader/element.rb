module MarkdownUI::Loader
  class Element
    def initialize(element, content, klass = nil)
      @element = element
      @content = content
      @klass   = klass
    end

    def render
      element = if @element.is_a? Array
                  @element.dup
                else
                  @element.split(' ')
                end

      content = @content

      # Add klass to element array if klass exists
      if @klass && !@klass.strip.empty?
        klass_parts = @klass.split(' ')
        element += klass_parts
      end

      MarkdownUI::Loader::Custom.new(element, content, nil).render
    end
  end
end