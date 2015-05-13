module MarkdownUI
  class Button
    def initialize(element, content, klass)
      @element = element
      @content = content
      @klass = klass
    end

    def render
      element = @element
      content = @content
      klass = @klass

      mode = OpenStruct.new(
        :icon?      => element.grep(/icon/i).any?,
        :flag?      => element.grep(/flag/i).any?,
        :image?     => element.grep(/image/i).any?,
        :focusable? => element.grep(/focusable/i).any?,
        :animated?  => element.grep(/animated/i).any?,
        :labeled?   => element.grep(/labeled/i).any?,
        :basic?     => element.grep(/basic/i).any?
      )

      if element.size > 2 && standard_button?(mode)
        MarkdownUI::CustomButton.new(element.join(" "), content, klass).render
      elsif mode.icon? && mode.labeled?
        icon, label = content
        MarkdownUI::LabeledIconButton.new(icon, label, klass).render
      elsif mode.icon? && !mode.labeled?
        MarkdownUI::IconButton.new(content, klass).render
      elsif mode.focusable?
        MarkdownUI::FocusableButton.new(content, klass).render
      elsif mode.basic?
        MarkdownUI::BasicButton.new(content, klass).render
      elsif mode.animated?
        visible_content, hidden_content = content.split(";")
        MarkdownUI::AnimatedButton.new(visible_content, hidden_content, klass).render
      else
        MarkdownUI::StandardButton.new(content, klass).render
      end
    end

    protected

    def standard_button?(mode)
      !mode.focusable? && !mode.animated? && !mode.icon? && !mode.labeled? && !mode.basic?
    end

  end
end