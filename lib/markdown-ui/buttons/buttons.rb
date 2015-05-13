module MarkdownUI
  class Buttons
    def initialize(element, content)
      @element = element
      @content = content
    end

    def render
      element = @element.strip
      content = @content.strip
      mode = OpenStruct.new(
        :icon?        => !(element =~ /icon/i).nil?
      )

      if element.length == "buttons".length
        MarkdownUI::StandardButtons.new(element, content).render
      elsif mode.icon?
        MarkdownUI::IconButtons.new(element, content).render
      else
        MarkdownUI::CustomButtons.new(element, content).render
      end
    end

  end
end