# coding: UTF-8
require_relative 'test_helper'

class ImageTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_standard_image
    markdown = '__Image|https://example.com/image.png__'
    output = @parser.render(markdown)
    assert_equal \
'<img class="ui image" src="https://example.com/image.png" />
', output
  end

  def test_image_with_alt_text
    markdown = '__Image|https://example.com/image.png|alt text__'
    output = @parser.render(markdown)
    assert_equal \
'<img class="ui image" src="https://example.com/image.png" alt="alt text" />
', output
  end

  def test_fluid_image
    markdown = '__Image|https://example.com/image.png|fluid__'
    output = @parser.render(markdown)
    assert_equal \
'<img class="ui fluid image" src="https://example.com/image.png" />
', output
  end

  def test_circular_image
    markdown = '__Image|https://example.com/image.png|circular__'
    output = @parser.render(markdown)
    assert_equal \
'<img class="ui circular image" src="https://example.com/image.png" />
', output
  end

  def test_avatar_image
    markdown = '__Image|https://example.com/avatar.jpg|avatar__'
    output = @parser.render(markdown)
    assert_equal \
'<img class="ui avatar image" src="https://example.com/avatar.jpg" />
', output
  end

  def test_bordered_image
    markdown = '__Image|https://example.com/image.png|bordered__'
    output = @parser.render(markdown)
    assert_equal \
'<img class="ui bordered image" src="https://example.com/image.png" />
', output
  end

  def test_rounded_image
    markdown = '__Image|https://example.com/image.png|rounded__'
    output = @parser.render(markdown)
    assert_equal \
'<img class="ui rounded image" src="https://example.com/image.png" />
', output
  end

  def test_disabled_image
    markdown = '__Image|https://example.com/image.png|disabled__'
    output = @parser.render(markdown)
    assert_equal \
'<img class="ui disabled image" src="https://example.com/image.png" />
', output
  end

  def test_sized_images
    markdown_mini = '__Image|https://example.com/image.png|mini__'
    output_mini = @parser.render(markdown_mini)
    assert_equal \
'<img class="ui mini image" src="https://example.com/image.png" />
', output_mini

    markdown_huge = '__Image|https://example.com/image.png|huge__'
    output_huge = @parser.render(markdown_huge)
    assert_equal \
'<img class="ui huge image" src="https://example.com/image.png" />
', output_huge
  end

  def test_image_with_multiple_classes
    markdown = '__Image|https://example.com/image.png|circular bordered__'
    output = @parser.render(markdown)
    assert_equal \
'<img class="ui circular bordered image" src="https://example.com/image.png" />
', output
  end
end