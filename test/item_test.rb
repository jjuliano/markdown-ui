# coding: UTF-8
require_relative 'test_helper'

class ItemTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_standard_item
    markdown = \
'> Item:
> ![Product](product.jpg)
> **Cute Dog**
> $22.99
> 
> This is a very cute dog'

    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui item">
  <div class="image">
    <img src="product.jpg" alt="Product" />
  </div>
  <div class="content">
    <div class="header">Cute Dog</div>
    <div class="meta">$22.99</div>
    <div class="description">
      <p>This is a very cute dog</p>
    </div>
  </div>
</div>
', output
  end

  def test_items_list
    markdown = \
'> Items:
> > Item:
> > ![Item1](item1.jpg)
> > **Item One**
> > Description one
> > Item:
> > ![Item2](item2.jpg)
> > **Item Two**
> > Description two'

    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui items">
  <div class="item">
    <div class="image">
      <img src="item1.jpg" alt="Item1" />
    </div>
    <div class="content">
      <div class="header">Item One</div>
      <div class="description">
        <p>Description one</p>
      </div>
    </div>
  </div>
  <div class="item">
    <div class="image">
      <img src="item2.jpg" alt="Item2" />
    </div>
    <div class="content">
      <div class="header">Item Two</div>
      <div class="description">
        <p>Description two</p>
      </div>
    </div>
  </div>
</div>
', output
  end

  def test_divided_items
    markdown = \
'> Divided Items:
> > Item:
> > **First Item**
> > First description
> > Item:
> > **Second Item**
> > Second description'

    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui divided items">
  <div class="item">
    <div class="content">
      <div class="header">First Item</div>
      <div class="description">
        <p>First description</p>
      </div>
    </div>
  </div>
  <div class="item">
    <div class="content">
      <div class="header">Second Item</div>
      <div class="description">
        <p>Second description</p>
      </div>
    </div>
  </div>
</div>
', output
  end

  def test_relaxed_items
    markdown = \
'> Relaxed Items:
> > Item:
> > **Relaxed Item**
> > With more spacing'

    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui relaxed items">
  <div class="item">
    <div class="content">
      <div class="header">Relaxed Item</div>
      <div class="description">
        <p>With more spacing</p>
      </div>
    </div>
  </div>
</div>
', output
  end
end