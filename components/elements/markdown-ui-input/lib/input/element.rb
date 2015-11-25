module MarkdownUI::Input
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

      content = @content

      klass = if @klass.nil?
                element.join(' ').strip
              else
                @klass
              end

      _id = @id

      MarkdownUI::Input::Custom.new(element, content, klass, _id).render
    end
  end
end
