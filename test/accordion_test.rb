# coding: UTF-8
require_relative 'test_helper'

class AccordionTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_standard_accordion
    markdown = \
'> Accordion:
> > Title: What is a dog?
> > Content: A dog is a type of domesticated animal.
> > Title: What kinds of dogs are there?
> > Content: There are many breeds of dogs. Each breed has unique characteristics.'

    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui accordion">
  <div class="title">
    <i class="dropdown icon"></i>
    What is a dog?
  </div>
  <div class="content">
    <p>A dog is a type of domesticated animal.</p>
  </div>
  <div class="title">
    <i class="dropdown icon"></i>
    What kinds of dogs are there?
  </div>
  <div class="content">
    <p>There are many breeds of dogs. Each breed has unique characteristics.</p>
  </div>
</div>
', output
  end

  def test_styled_accordion
    markdown = \
'> Styled Accordion:
> > Title: Section 1
> > Content: Content for section 1
> > Title: Section 2  
> > Content: Content for section 2'

    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui styled accordion">
  <div class="title">
    <i class="dropdown icon"></i>
    Section 1
  </div>
  <div class="content">
    <p>Content for section 1</p>
  </div>
  <div class="title">
    <i class="dropdown icon"></i>
    Section 2
  </div>
  <div class="content">
    <p>Content for section 2</p>
  </div>
</div>
', output
  end

  def test_fluid_accordion
    markdown = \
'> Fluid Accordion:
> > Title: Fluid Section
> > Content: This accordion takes full width'

    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui fluid accordion">
  <div class="title"><i class="dropdown icon"></i>
    Fluid Section
  </div>
  <div class="content">
    <p>This accordion takes full width</p>
  </div>
</div>
', output
  end

  def test_inverted_accordion
    markdown = \
'> Inverted Accordion:
> > Title: Dark Theme
> > Content: This accordion has dark styling'

    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui inverted accordion">
  <div class="title"><i class="dropdown icon"></i>
    Dark Theme
  </div>
  <div class="content">
    <p>This accordion has dark styling</p>
  </div>
</div>
', output
  end
end