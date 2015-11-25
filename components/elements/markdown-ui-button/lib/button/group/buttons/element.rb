module MarkdownUI
  module Button
    module Group
      module Buttons
        class Element
          def initialize(element, content)
            @element = element
            @content = content
          end

          def render
            element = @element.strip
            content = @content.strip
            mode    = OpenStruct.new(
                :icon? => !(element =~ /icon/i).nil?
            )

            if element.length == 'buttons'.length
              MarkdownUI::Button::Group::Buttons::Standard.new(element, content).render
            elsif mode.icon?
              MarkdownUI::Button::Group::Buttons::Icon.new(element, content).render
            else
              MarkdownUI::Button::Group::Buttons::Custom.new(element, content).render
            end
          end
        end
      end
    end
  end
end
