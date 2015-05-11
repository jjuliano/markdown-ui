module MarkdownUI
  class Segment
    def initialize(element, content)
      @mode = OpenStruct.new(
        :segment?   => !(element =~ /segment/i).nil?
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
      if @mode.segment?
        MarkdownUI::StandardSegment.new(@element, @content).render
        #
        # if @mode.left? && @mode.aligned?
        #   MarkdownUI::LeftAlignedContainer.new(@element, @content).render
        # elsif @mode.right? && @mode.aligned?
        #   MarkdownUI::RightAlignedContainer.new(@element, @content).render
        # elsif @mode.center? && @mode.aligned?
        #   MarkdownUI::CenterAlignedContainer.new(@element, @content).render
        # elsif @mode.text?
        #   MarkdownUI::TextContainer.new(@element, @content).render
        # else
        #   MarkdownUI::CustomContainer.new(@element, @content).render
        # end
      end
    end

  end
end