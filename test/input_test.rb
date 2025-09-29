# coding: UTF-8

require_relative 'test_helper'

class InputTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_basic_input
    markdown = "__input|Enter text__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui input input'><input type='text' placeholder='Enter text' /></div>", output
  end

  def test_large_input
    markdown = "__large input|Large text field__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui large input input'><input type='text' placeholder='Large text field' /></div>", output
  end

  def test_small_input
    markdown = "__small input|Small text field__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui small input input'><input type='text' placeholder='Small text field' /></div>", output
  end

  def test_fluid_input
    markdown = "__fluid input|Full width input__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui fluid input input'><input type='text' placeholder='Full width input' /></div>", output
  end

  def test_icon_input
    markdown = "__icon input|Search__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui icon input input'><input type='text' placeholder='Search' /></div>", output
  end

  def test_labeled_input
    markdown = "__labeled input|Username__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui labeled input input'><input type='text' placeholder='Username' /></div>", output
  end

  def test_action_input
    markdown = "__action input|Enter URL__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui action input input'><input type='text' placeholder='Enter URL' /></div>", output
  end

  def test_transparent_input
    markdown = "__transparent input|Transparent field__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui transparent input input'><input type='text' placeholder='Transparent field' /></div>", output
  end

  def test_inverted_input
    markdown = "__inverted input|Dark theme input__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui inverted input input'><input type='text' placeholder='Dark theme input' /></div>", output
  end

  def test_focus_input
    markdown = "__focus input|Focused input__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui focus input input'><input type='text' placeholder='Focused input' /></div>", output
  end

  def test_loading_input
    markdown = "__loading input|Loading state__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui loading input input'><input type='text' placeholder='Loading state' /></div>", output
  end

  def test_disabled_input
    markdown = "__disabled input|Disabled field__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui disabled input input'><input type='text' placeholder='Disabled field' /></div>", output
  end

  def test_error_input
    markdown = "__error input|Error state__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui error input input'><input type='text' placeholder='Error state' /></div>", output
  end
end