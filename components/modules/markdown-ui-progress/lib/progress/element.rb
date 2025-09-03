module MarkdownUI::Progress
  class Element
    def initialize(element, content, klass = nil, id = nil, data_attributes = nil)
      @element = element
      @content = content
      @klass   = klass
      @id      = id
      @data_attributes = data_attributes
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

      MarkdownUI::Progress::Custom.new(element, content, klass, @id, @data_attributes).render
    end
  end
end