# coding: UTF-8
require_relative 'test_helper'

class ModalTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_standard_modal
    markdown = \
'> Modal:
> **Delete Your Account**
> 
> Are you sure you want to delete your account? This action cannot be undone.
> 
> __Button|Cancel__
> __Button|Delete|negative__'

    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui modal">
  <div class="header">Delete Your Account</div>
  <div class="content">
    <p>Are you sure you want to delete your account? This action cannot be undone.</p>
  </div>
  <div class="actions">
    <button class="ui button">Cancel</button>
    <button class="ui negative button">Delete</button>
  </div>
</div>', output
  end

  def test_basic_modal
    markdown = \
'> Basic Modal:
> **Basic Modal**
> 
> This is a basic modal with minimal styling.'

    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui basic modal">
  <div class="header">Basic Modal</div>
  <div class="content">
    <p>This is a basic modal with minimal styling.</p>
  </div>
</div>
', output
  end

  def test_fullscreen_modal
    markdown = \
'> Fullscreen Modal:
> **Full Screen**
> 
> This modal takes up the entire screen.'

    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui fullscreen modal">
  <div class="header">Full Screen</div>
  <div class="content">
    <p>This modal takes up the entire screen.</p>
  </div>
</div>
', output
  end

  def test_small_modal
    markdown = \
'> Small Modal:
> **Small Modal**
> 
> This is a small sized modal.'

    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui small modal">
  <div class="header">Small Modal</div>
  <div class="content">
    <p>This is a small sized modal.</p>
  </div>
</div>
', output
  end

  def test_large_modal
    markdown = \
'> Large Modal:
> **Large Modal**
> 
> This is a large sized modal.'

    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui large modal">
  <div class="header">Large Modal</div>
  <div class="content">
    <p>This is a large sized modal.</p>
  </div>
</div>
', output
  end

  def test_modal_with_image
    markdown = \
'> Image Modal:
> ![Modal Image](image.jpg)
> **Image Modal**
>
> This modal contains an image.'

    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui image modal">
  <div class="image">
    <img src="image.jpg" alt="Modal Image" />
  </div>
  <div class="header">Image Modal</div>
  <div class="content">
    <p>This modal contains an image.</p>
  </div>
</div>
', output
  end

  def test_scrolling_modal
    markdown = \
'> Scrolling Modal:
> **Long Content**
> 
> This modal has scrolling content when it becomes too long.'

    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui scrolling modal">
  <div class="header">Long Content</div>
  <div class="content">
    <p>This modal has scrolling content when it becomes too long.</p>
  </div>
</div>
', output
  end
end