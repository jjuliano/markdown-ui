module MarkdownUI::Label
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

      klass = if @klass.nil?
        element.join(" ").strip
      else
        @klass
      end

      MarkdownUI::Label::Custom.new(element, content, klass).render
    end

    protected

    def standard_label?(mode)
      !mode.image? && !mode.secondary? && !mode.pagination? && !mode.pointing? && !mode.tabular? && !mode.text? && !mode.vertical?
    end

  end
end