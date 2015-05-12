# coding: UTF-8

module MarkdownUI
  class Container
    def initialize(element, content)
      @mode = OpenStruct.new(
        :container? => !(element =~ /container/i).nil?,
        :text?      => !(element =~ /text/i).nil?,
        :left?      => !(element =~ /left/i).nil?,
        :right?     => !(element =~ /right/i).nil?,
        :center?    => !(element =~ /center/i).nil?,
        :aligned?   => !(element =~ /aligned/i).nil?
      )
      @element = element
      @content = content
    end

    # :segment?   => !(ui_element =~ /segment/i).nil?,
    # :page?      => !(ui_element =~ /page/i).nil?,
    # :grid?      => !(ui_element =~ /grid/i).nil?,
    # :column?    => !(ui_element =~ /column/i).nil?,
    # :row?       => !(ui_element =~ /row/i).nil?,
    # :header?    => !(ui_element =~ /header/i).nil?,
    #

    def render
      if @mode.container?
        if @element.length == "container".length
          MarkdownUI::StandardContainer.new(@element, @content).render
        elsif @mode.left? && @mode.aligned?
          MarkdownUI::LeftAlignedContainer.new(@element, @content).render
        elsif @mode.right? && @mode.aligned?
          MarkdownUI::RightAlignedContainer.new(@element, @content).render
        elsif @mode.center? && @mode.aligned?
          MarkdownUI::CenterAlignedContainer.new(@element, @content).render
        elsif @mode.text?
          MarkdownUI::TextContainer.new(@element, @content).render
        else
          MarkdownUI::CustomContainer.new(@element, @content).render
        end
      end
    end

  end
end