# coding: UTF-8

require_relative 'test_helper'

class DropdownTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_basic_dropdown
    markdown = "__dropdown|Gender|Male,Female__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui dropdown'><input type='hidden' name='gender'><i class='dropdown icon'></i><div class='default text'>Gender</div><div class='menu'><div class='item' data-value='male'>Male</div><div class='item' data-value='female'>Female</div></div></div>", output
  end

  def test_selection_dropdown
    markdown = "__selection dropdown|Choose Item|Item1,Item2__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui selection dropdown'><input type='hidden' name='choose_item'><i class='dropdown icon'></i><div class='default text'>Choose Item</div><div class='menu'><div class='item' data-value='item1'>Item1</div><div class='item' data-value='item2'>Item2</div></div></div>", output
  end

  def test_fluid_search_selection_dropdown
    markdown = "__fluid search selection dropdown|Choose Item|Item1,Item2__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui selection dropdown'><input type='hidden' name='choose_item'><i class='dropdown icon'></i><div class='default text'>Choose Item</div><div class='menu'><div class='item' data-value='item1'>Item1</div><div class='item' data-value='item2'>Item2</div></div></div>", output
  end

  def test_search_dropdown
    markdown = "__search dropdown|Search and Select|Item1,Item2__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui search dropdown'><input type='hidden' name='search_item'><i class='dropdown icon'></i><div class='default text'>Search and Select</div><div class='menu'><div class='item' data-value='item1'>Item1</div><div class='item' data-value='item2'>Item2</div></div></div>", output
  end

  def test_multiple_dropdown
    markdown = "__multiple dropdown|Select Multiple|Item0,Item1,Item2__"
    output = @parser.render(markdown)
    assert_equal "<select multiple='' name='select_multiple' class='ui fluid normal dropdown'><option value='item0'>Item0</option><option value='item1'>Item1</option><option value='item2'>Item2</option></select>", output
  end

  def test_fluid_dropdown
    markdown = "__fluid dropdown|Full Width|Item0,Item1,Item2__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui fluid dropdown'><input type='hidden' name='full_width'><i class='dropdown icon'></i><div class='default text'>Full Width</div><div class='menu'><div class='item' data-value='item0'>Item0</div><div class='item' data-value='item1'>Item1</div><div class='item' data-value='item2'>Item2</div></div></div>", output
  end

  def test_compact_dropdown
    markdown = "__compact dropdown|Compact Size|Item0,Item1,Item2__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui compact dropdown'><input type='hidden' name='compact_size'><i class='dropdown icon'></i><div class='default text'>Compact Size</div><div class='menu'><div class='item' data-value='item0'>Item0</div><div class='item' data-value='item1'>Item1</div><div class='item' data-value='item2'>Item2</div></div></div>", output
  end

  def test_floating_dropdown
    markdown = "__floating dropdown|Floating Style|Item0,Item1,Item2__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui floating dropdown'><input type='hidden' name='floating_style'><i class='dropdown icon'></i><div class='default text'>Floating Style</div><div class='menu'><div class='item' data-value='item0'>Item0</div><div class='item' data-value='item1'>Item1</div><div class='item' data-value='item2'>Item2</div></div></div>", output
  end

  def test_labeled_dropdown
    markdown = "__labeled dropdown|With Label|Item0,Item1,Item2__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui labeled dropdown'><input type='hidden' name='with_label'><i class='dropdown icon'></i><div class='default text'>With Label</div><div class='menu'><div class='item' data-value='item0'>Item0</div><div class='item' data-value='item1'>Item1</div><div class='item' data-value='item2'>Item2</div></div></div>", output
  end

  def test_button_dropdown
    markdown = "__button dropdown|Button Style|Item0,Item1,Item2__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui button dropdown'><input type='hidden' name='button_style'><i class='dropdown icon'></i><div class='default text'>Button Style</div><div class='menu'><div class='item' data-value='item0'>Item0</div><div class='item' data-value='item1'>Item1</div><div class='item' data-value='item2'>Item2</div></div></div>", output
  end

  def test_inline_dropdown
    markdown = "__inline dropdown|Inline Style|Item0,Item1,Item2__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui inline dropdown'><input type='hidden' name='inline_style'><i class='dropdown icon'></i><div class='default text'>Inline Style</div><div class='menu'><div class='item' data-value='item0'>Item0</div><div class='item' data-value='item1'>Item1</div><div class='item' data-value='item2'>Item2</div></div></div>", output
  end
end