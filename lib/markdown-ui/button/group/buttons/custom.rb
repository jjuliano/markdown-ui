# coding: UTF-8

module MarkdownUI::Button
  module Group
    module Buttons
      class Custom
        def initialize(element, content)
          @element = element
          @content = content
        end

        def render
          klass = "ui #{@element} buttons"
          content = @content.strip

          MarkdownUI::StandardTag.new(content, klass).render
        end
      end
    end
  end
end