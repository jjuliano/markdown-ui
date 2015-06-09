module MarkdownUI::Menu
  class Element
    def initialize(element, content, klass = nil)
      @element = element
      @content = content
      @klass = klass
    end

    def render
      element = if @element.is_a? Array
        @element
      else
        @element.split(" ")
      end

      content = @content
      klass = @klass

      mode = OpenStruct.new(
        :item?      => element.grep(/item/i).any?
      )

      if mode.item?
        MarkdownUI::Menu::Custom.new(element, content, klass).render
      elsif standard_menu?(mode)
        MarkdownUI::Menu::Standard.new(content, klass).render
      end
    end

    protected

    def standard_menu?(mode)
      !mode.item?
    end

  end
end