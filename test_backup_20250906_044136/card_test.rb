# coding: UTF-8
require_relative 'test_helper'

class CardTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_standard_card
    markdown = \
'> Card:
> **John Doe**
> Software Developer
> 
> A passionate developer with 5 years of experience.'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui card">
  <div class="content">
    <div class="header">John Doe</div>
    <div class="meta">Software Developer</div>
    <div class="description">
      <p>A passionate developer with 5 years of experience.</p>
    </div>
  </div>
</div>
', output
  end

  def test_card_with_image
    markdown = \
'> Image Card:
> ![Avatar](https://semantic-ui.com/images/avatar/large/matthew.png)
> **Matthew**
> Friend'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui card">
  <div class="image">
    <img src="https://semantic-ui.com/images/avatar/large/matthew.png" alt="Avatar" />
  </div>
  <div class="content">
    <div class="header">Matthew</div>
    <div class="meta">Friend</div>
  </div>
</div>
', output
  end

  def test_raised_card
    markdown = \
'> Raised Card:
> **Elevated**
> This card appears raised'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui raised card">
  <div class="content">
    <div class="header">Elevated</div>
    <div class="description">
      <p>This card appears raised</p>
    </div>
  </div>
</div>
', output
  end

  def test_centered_card
    markdown = \
'> Centered Card:
> **Centered Content**
> This card is centered'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui centered card">
  <div class="content">
    <div class="header">Centered Content</div>
    <div class="description">
      <p>This card is centered</p>
    </div>
  </div>
</div>
', output
  end

  def test_fluid_card
    markdown = \
'> Fluid Card:
> **Full Width**
> This card takes full width'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui fluid card">
  <div class="content">
    <div class="header">Full Width</div>
    <div class="description">
      <p>This card takes full width</p>
    </div>
  </div>
</div>
', output
  end

  def test_colored_card
    markdown = \
'> Red Card:
> **Error State**
> This is a red colored card'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui red card">
  <div class="content">
    <div class="header">Error State</div>
    <div class="description">
      <p>This is a red colored card</p>
    </div>
  </div>
</div>
', output
  end

  def test_inverted_card
    markdown = \
'> Inverted Card:
> **Dark Theme**
> This card has inverted colors'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui inverted card">
  <div class="content">
    <div class="header">Dark Theme</div>
    <div class="description">
      <p>This card has inverted colors</p>
    </div>
  </div>
</div>
', output
  end

  def test_cards_group
    markdown = \
'> Cards:
> > Card:
> > **Card 1**
> > First card
> > Card:
> > **Card 2**
> > Second card'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui cards">
  <div class="card">
    <div class="content">
      <div class="header">Card 1</div>
      <div class="description">
        <p>First card</p>
      </div>
    </div>
  </div>
  <div class="card">
    <div class="content">
      <div class="header">Card 2</div>
      <div class="description">
        <p>Second card</p>
      </div>
    </div>
  </div>
</div>
', output
  end
end