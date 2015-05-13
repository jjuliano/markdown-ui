module MarkdownUI
  class Message
    def initialize(element, content, klass)
      @element = element
      @content = content
      @klass = klass
    end

    def render
      element = @element
      klass = @klass
      content = @content

      mode = OpenStruct.new(
        :warning?   => element.grep(/warning/i).any?
      )

      if element.size > 2
        MarkdownUI::CustomMessage.new(element.join(" "), content, klass).render
      else
        MarkdownUI::StandardMessage.new(content, klass).render
      end
    end

  end
end