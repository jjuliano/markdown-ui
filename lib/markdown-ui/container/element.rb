# coding: UTF-8

module MarkdownUI::Container
  class Element
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
        MarkdownUI::Container::Standard.new(element, content).render
      elsif mode.left? && mode.aligned?
        MarkdownUI::Container::Alignment::Left.new(element, content).render
      elsif mode.right? && mode.aligned?
        MarkdownUI::Container::Alignment::Right.new(element, content).render
      elsif mode.center? && mode.aligned?
        MarkdownUI::Container::Alignment::Center.new(element, content).render
      elsif mode.text?
        MarkdownUI::Container::Text.new(element, content).render
      else
        MarkdownUI::Container::Custom.new(element, content).render
      end
    end

  end
end
