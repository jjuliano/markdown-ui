# coding: UTF-8

require_relative 'test_helper'

class TextTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_basic_text
    markdown = "__text|Sample text content__"
    output = @parser.render(markdown)
    assert_equal "<span class='ui text text'>Sample text content</span>", output
  end

  def test_disabled_text
    markdown = "__disabled text|Disabled text__"
    output = @parser.render(markdown)
    assert_equal "<span class='ui disabled text text'>Disabled text</span>", output
  end

  def test_error_text
    markdown = "__error text|Error message__"
    output = @parser.render(markdown)
    assert_equal "<span class='ui error text text'>Error message</span>", output
  end

  def test_muted_text
    markdown = "__muted text|Secondary information__"
    output = @parser.render(markdown)
    assert_equal "<span class='ui muted text text'>Secondary information</span>", output
  end

  def test_inverted_text
    markdown = "__inverted text|Light text on dark background__"
    output = @parser.render(markdown)
    assert_equal "<span class='ui inverted text text'>Light text on dark background</span>", output
  end

  def test_colored_text
    markdown = "__red text|Error text__"
    output = @parser.render(markdown)
    assert_equal "<span class='ui red text text'>Error text</span>", output
  end

  def test_blue_text
    markdown = "__blue text|Information text__"
    output = @parser.render(markdown)
    assert_equal "<span class='ui blue text text'>Information text</span>", output
  end

  def test_green_text
    markdown = "__green text|Success text__"
    output = @parser.render(markdown)
    assert_equal "<span class='ui green text text'>Success text</span>", output
  end

  def test_yellow_text
    markdown = "__yellow text|Warning text__"
    output = @parser.render(markdown)
    assert_equal "<span class='ui yellow text text'>Warning text</span>", output
  end

  def test_orange_text
    markdown = "__orange text|Alert text__"
    output = @parser.render(markdown)
    assert_equal "<span class='ui orange text text'>Alert text</span>", output
  end

  def test_purple_text
    markdown = "__purple text|Special text__"
    output = @parser.render(markdown)
    assert_equal "<span class='ui purple text text'>Special text</span>", output
  end

  def test_pink_text
    markdown = "__pink text|Highlight text__"
    output = @parser.render(markdown)
    assert_equal "<span class='ui pink text text'>Highlight text</span>", output
  end

  def test_teal_text
    markdown = "__teal text|Cool text__"
    output = @parser.render(markdown)
    assert_equal "<span class='ui teal text text'>Cool text</span>", output
  end

  def test_brown_text
    markdown = "__brown text|Earth tone text__"
    output = @parser.render(markdown)
    assert_equal "<span class='ui brown text text'>Earth tone text</span>", output
  end

  def test_grey_text
    markdown = "__grey text|Neutral text__"
    output = @parser.render(markdown)
    assert_equal "<span class='ui grey text text'>Neutral text</span>", output
  end

  def test_black_text
    markdown = "__black text|Dark text__"
    output = @parser.render(markdown)
    assert_equal "<span class='ui black text text'>Dark text</span>", output
  end
end