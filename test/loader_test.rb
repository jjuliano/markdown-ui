# coding: UTF-8

require_relative 'test_helper'

class LoaderTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_basic_loader
    markdown = "__loader|Loading...__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui loader loader'>Loading...</div>", output
  end

  def test_active_loader
    markdown = "__active loader|Processing__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui active loader loader'>Processing</div>", output
  end

  def test_disabled_loader
    markdown = "__disabled loader|Inactive__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui disabled loader loader'>Inactive</div>", output
  end

  def test_indeterminate_loader
    markdown = "__indeterminate loader|Working__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui indeterminate loader loader'>Working</div>", output
  end

  def test_text_loader
    markdown = "__text loader|Please wait__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui text loader loader'>Please wait</div>", output
  end

  def test_inline_loader
    markdown = "__inline loader|Loading inline__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui inline loader loader'>Loading inline</div>", output
  end

  def test_centered_inline_loader
    markdown = "__centered inline loader|Centered__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui centered inline loader loader'>Centered</div>", output
  end

  def test_inverted_loader
    markdown = "__inverted loader|Dark theme__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui inverted loader loader'>Dark theme</div>", output
  end

  def test_elastic_loader
    markdown = "__elastic loader|Elastic motion__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui elastic loader loader'>Elastic motion</div>", output
  end

  def test_slow_loader
    markdown = "__slow loader|Slow animation__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui slow loader loader'>Slow animation</div>", output
  end

  def test_fast_loader
    markdown = "__fast loader|Fast animation__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui fast loader loader'>Fast animation</div>", output
  end

  def test_mini_loader
    markdown = "__mini loader|Tiny__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui mini loader loader'>Tiny</div>", output
  end

  def test_small_loader
    markdown = "__small loader|Small__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui small loader loader'>Small</div>", output
  end

  def test_medium_loader
    markdown = "__medium loader|Medium__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui medium loader loader'>Medium</div>", output
  end

  def test_large_loader
    markdown = "__large loader|Large__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui large loader loader'>Large</div>", output
  end
end