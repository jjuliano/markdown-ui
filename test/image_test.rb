# coding: UTF-8

require_relative 'test_helper'

class ImageTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_basic_image
    markdown = "![Alt text](https://example.com/image.jpg)"
    output = @parser.render(markdown)
    assert_includes output, "<img class='ui image'"
    assert_includes output, "src='https://example.com/image.jpg'"
    assert_includes output, "alt='Alt text'"
  end

  def test_image_with_title
    markdown = '![Alt text](https://example.com/image.jpg "Image Title")'
    output = @parser.render(markdown)
    assert_includes output, "<img class='ui image'"
    assert_includes output, "title='Image Title'"
  end

  def test_image_variations
    markdown = "__Image: fluid | Fluid Image | https://example.com/image.jpg__"
    output = @parser.render(markdown)
    assert_includes output, "class='ui fluid image'"
  end

  def test_avatar_image
    markdown = "__Image: avatar | User Avatar | https://example.com/avatar.jpg__"
    output = @parser.render(markdown)
    assert_includes output, "class='ui avatar image'"
  end

  def test_circular_image
    markdown = "__Image: circular | Profile Picture | https://example.com/profile.jpg__"
    output = @parser.render(markdown)
    assert_includes output, "class='ui circular image'"
  end

  def test_rounded_image
    markdown = "__rounded image|https://example.com/rounded.jpg__"
    output = @parser.render(markdown)
    assert_equal "<img class='ui rounded image' src='https://example.com/rounded.jpg' />", output
  end

  def test_bordered_image
    markdown = "__bordered image|https://example.com/bordered.jpg__"
    output = @parser.render(markdown)
    assert_equal "<img class='ui bordered image' src='https://example.com/bordered.jpg' />", output
  end

  def test_tiny_image
    markdown = "__tiny image|https://example.com/tiny.jpg__"
    output = @parser.render(markdown)
    assert_equal "<img class='ui tiny image' src='https://example.com/tiny.jpg' />", output
  end

  def test_mini_image
    markdown = "__mini image|https://example.com/mini.jpg__"
    output = @parser.render(markdown)
    assert_equal "<img class='ui mini image' src='https://example.com/mini.jpg' />", output
  end

  def test_small_image
    markdown = "__small image|https://example.com/small.jpg__"
    output = @parser.render(markdown)
    assert_equal "<img class='ui small image' src='https://example.com/small.jpg' />", output
  end

  def test_medium_image
    markdown = "__medium image|https://example.com/medium.jpg__"
    output = @parser.render(markdown)
    assert_equal "<img class='ui medium image' src='https://example.com/medium.jpg' />", output
  end

  def test_large_image
    markdown = "__large image|https://example.com/large.jpg__"
    output = @parser.render(markdown)
    assert_equal "<img class='ui large image' src='https://example.com/large.jpg' />", output
  end

  def test_big_image
    markdown = "__big image|https://example.com/big.jpg__"
    output = @parser.render(markdown)
    assert_equal "<img class='ui big image' src='https://example.com/big.jpg' />", output
  end

  def test_huge_image
    markdown = "__huge image|https://example.com/huge.jpg__"
    output = @parser.render(markdown)
    assert_equal "<img class='ui huge image' src='https://example.com/huge.jpg' />", output
  end

  def test_massive_image
    markdown = "__massive image|https://example.com/massive.jpg__"
    output = @parser.render(markdown)
    assert_equal "<img class='ui massive image' src='https://example.com/massive.jpg' />", output
  end

  def test_centered_image
    markdown = "__centered image|https://example.com/centered.jpg__"
    output = @parser.render(markdown)
    assert_equal "<img class='ui centered image' src='https://example.com/centered.jpg' />", output
  end

  def test_spaced_image
    markdown = "__spaced image|https://example.com/spaced.jpg__"
    output = @parser.render(markdown)
    assert_equal "<img class='ui spaced image' src='https://example.com/spaced.jpg' />", output
  end

  def test_floated_image
    markdown = "__left floated image|https://example.com/floated.jpg__"
    output = @parser.render(markdown)
    assert_equal "<img class='ui left floated image' src='https://example.com/floated.jpg' />", output
  end

  def test_right_floated_image
    markdown = "__right floated image|https://example.com/right.jpg__"
    output = @parser.render(markdown)
    assert_equal "<img class='ui right floated image' src='https://example.com/right.jpg' />", output
  end

  def test_vertically_aligned_image
    markdown = "__top aligned image|https://example.com/aligned.jpg__"
    output = @parser.render(markdown)
    assert_equal "<img class='ui top aligned image' src='https://example.com/aligned.jpg' />", output
  end
end