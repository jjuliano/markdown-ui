# coding: UTF-8

require_relative 'test_helper'

class CheckboxTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_basic_checkbox
    markdown = "__checkbox|Accept Terms__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui checkbox checkbox'>Accept Terms</div>", output
  end

  def test_radio_checkbox
    markdown = "__radio checkbox|Option 1__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui radio checkbox checkbox'>Option 1</div>", output
  end

  def test_slider_checkbox
    markdown = "__slider checkbox|Enable Feature__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui slider checkbox checkbox'>Enable Feature</div>", output
  end

  def test_toggle_checkbox
    markdown = "__toggle checkbox|Dark Mode__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui toggle checkbox checkbox'>Dark Mode</div>", output
  end

  def test_fitted_checkbox
    markdown = "__fitted checkbox|Compact__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui fitted checkbox checkbox'>Compact</div>", output
  end

  def test_disabled_checkbox
    markdown = "__disabled checkbox|Cannot Select__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui disabled checkbox checkbox'>Cannot Select</div>", output
  end

  def test_checked_checkbox
    markdown = "__checked checkbox|Pre-selected__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui checked checkbox checkbox'>Pre-selected</div>", output
  end

  def test_indeterminate_checkbox
    markdown = "__indeterminate checkbox|Mixed State__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui indeterminate checkbox checkbox'>Mixed State</div>", output
  end

  def test_inverted_checkbox
    markdown = "__inverted checkbox|Dark Theme__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui inverted checkbox checkbox'>Dark Theme</div>", output
  end
end