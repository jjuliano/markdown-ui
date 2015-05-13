# coding: UTF-8

module MarkdownUI
  class Container
    def initialize(element, content)
      @element = element
      @content = content
    end

    def render
      element = @element.strip
      content = @content.strip

      mode = OpenStruct.new(
        :text?      => !(element =~ /text/i).nil?,
        :left?      => !(element =~ /left/i).nil?,
        :right?     => !(element =~ /right/i).nil?,
        :center?    => !(element =~ /center/i).nil?,
        :aligned?   => !(element =~ /aligned/i).nil?
      )

      if element.length == "container".length
        MarkdownUI::StandardContainer.new(element, content).render
      elsif mode.left? && mode.aligned?
        MarkdownUI::LeftAlignedContainer.new(element, content).render
      elsif mode.right? && mode.aligned?
        MarkdownUI::RightAlignedContainer.new(element, content).render
      elsif mode.center? && mode.aligned?
        MarkdownUI::CenterAlignedContainer.new(element, content).render
      elsif mode.text?
        MarkdownUI::TextContainer.new(element, content).render
      else
        MarkdownUI::CustomContainer.new(element, content).render
      end
    end

  end
end