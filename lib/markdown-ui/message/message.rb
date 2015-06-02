module MarkdownUI
  class Message
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
        :list?   => element.grep(/list/i).any?,
        :icon?   => element.grep(/icon/i).any?,
        :dismissable? => element.grep(/dismissable/i).any?
      )

      if standard_message?(mode) && element.size > 1
        MarkdownUI::CustomMessage.new(element, content, klass).render
      elsif mode.list?
        MarkdownUI::ListMessage.new(content, klass).render
      else standard_message?(mode)
        MarkdownUI::StandardMessage.new(content, klass).render
      end
    end

    protected

    def standard_message?(mode)
      !mode.list? && !mode.icon? && !mode.dismissable?
    end
  end
end