# coding: UTF-8
require_relative 'test_helper'

class LabelTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_standard_label
    markdown = '__Label|New__'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui label">New</div>
', output
  end

  def test_image_label
    markdown = '__Label|Elliot|image https://semantic-ui.com/images/avatar/small/elliot.jpg__'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui image label"><img src="https://semantic-ui.com/images/avatar/small/elliot.jpg" />
  Elliot
</div>
', output
  end

  def test_pointing_label
    markdown = '__Label|Please enter a value|pointing__'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui pointing label">Please enter a value</div>
', output
  end

  def test_corner_label
    markdown = '__Label|New|corner__'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui corner label">
  <i class="icon"></i>
</div>
', output
  end

  def test_tag_label
    markdown = '__Label|Featured|tag__'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui tag label">Featured</div>
', output
  end

  def test_ribbon_label
    markdown = '__Label|Special Offer|ribbon__'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui ribbon label">Special Offer</div>
', output
  end

  def test_colored_labels
    markdown_red = '__Label|Red|red__'
    output_red = @parser.render(markdown_red)
    assert_equal \
'<div class="ui red label">Red</div>
', output_red

    markdown_blue = '__Label|Blue|blue__'
    output_blue = @parser.render(markdown_blue)
    assert_equal \
'<div class="ui blue label">Blue</div>
', output_blue
  end

  def test_sized_labels
    markdown_mini = '__Label|Mini|mini__'
    output_mini = @parser.render(markdown_mini)
    assert_equal \
'<div class="ui mini label">Mini</div>
', output_mini

    markdown_huge = '__Label|Huge|huge__'
    output_huge = @parser.render(markdown_huge)
    assert_equal \
'<div class="ui huge label">Huge</div>
', output_huge
  end

  def test_circular_label
    markdown = '__Label|1|circular__'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui circular label">1</div>
', output
  end

  def test_basic_label
    markdown = '__Label|Basic|basic__'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui basic label">Basic</div>
', output
  end

  def test_basic_colored_label
    markdown = '__Label|Basic Red|basic red__'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui basic red label">Basic Red</div>', output
  end

  def test_label_with_detail
    markdown = '__Label|Mail|detail 23__'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui label">Mail
  <div class="detail">23</div>
</div>', output
  end

  def test_label_with_icon
    markdown = '__Label|Mail|icon mail__'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui label"><i class="mail icon"></i>
  Mail
</div>', output
  end
end