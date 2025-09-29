# coding: UTF-8

require_relative 'test_helper'

class FieldTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_basic_field
    markdown = "__field|Field content__"
    output = @parser.render(markdown)
    assert_equal "<div class='field field'>Field content</div>", output
  end

  def test_required_field
    markdown = "__required field|Required field__"
    output = @parser.render(markdown)
    assert_equal "<div class='required field field'>Required field</div>", output
  end

  def test_error_field
    markdown = "__error field|Error field__"
    output = @parser.render(markdown)
    assert_equal "<div class='error field field'>Error field</div>", output
  end

  def test_disabled_field
    markdown = "__disabled field|Disabled field__"
    output = @parser.render(markdown)
    assert_equal "<div class='disabled field field'>Disabled field</div>", output
  end

  def test_inline_field
    markdown = "__inline field|Inline field__"
    output = @parser.render(markdown)
    assert_equal "<div class='inline field field'>Inline field</div>", output
  end

  def test_grouped_field
    markdown = "__grouped field|Grouped fields__"
    output = @parser.render(markdown)
    assert_equal "<div class='grouped field field'>Grouped fields</div>", output
  end

  def test_wide_field
    markdown = "__wide field|Wide field__"
    output = @parser.render(markdown)
    assert_equal "<div class='wide field field'>Wide field</div>", output
  end

  def test_two_wide_field
    markdown = "__two wide field|Two wide field__"
    output = @parser.render(markdown)
    assert_equal "<div class='two wide field field'>Two wide field</div>", output
  end

  def test_three_wide_field
    markdown = "__three wide field|Three wide field__"
    output = @parser.render(markdown)
    assert_equal "<div class='three wide field field'>Three wide field</div>", output
  end
end