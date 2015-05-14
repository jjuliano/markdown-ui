module MarkdownUI::Button
  module Group
    class Element
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
          MarkdownUI::Button::Group::Standard.new(element, content).render
        elsif mode.icon?
          MarkdownUI::Button::Group::Icon.new(element, content).render
        else
          MarkdownUI::Button::Group::Custom.new(element, content).render
        end
      end
    end
  end
end