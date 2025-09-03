# coding: UTF-8
require_relative 'test_helper'

class DropdownTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_standard_dropdown
    markdown = \
'__Dropdown|Select Option|Option 1,Option 2,Option 3__'

    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui dropdown">
  <div class="default text">Select Option</div>
  <i class="dropdown icon"></i>
  <div class="menu">
    <div class="item">Option 1</div>
    <div class="item">Option 2</div>
    <div class="item">Option 3</div>
  </div>
</div>
', output
  end

  def test_selection_dropdown
    markdown = \
'__Dropdown|Choose Country|USA,Canada,Mexico|selection__'

    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui selection dropdown">
  <div class="default text">Choose Country</div>
  <i class="dropdown icon"></i>
  <div class="menu">
    <div class="item">USA</div>
    <div class="item">Canada</div>
    <div class="item">Mexico</div>
  </div>
</div>
', output
  end

  def test_search_dropdown
    markdown = \
'__Dropdown|Search Skills|JavaScript,Python,Ruby|search__'

    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui search dropdown">
  <div class="default text">Search Skills</div>
  <i class="dropdown icon"></i>
  <div class="menu">
    <div class="item">JavaScript</div>
    <div class="item">Python</div>
    <div class="item">Ruby</div>
  </div>
</div>
', output
  end

  def test_multiple_dropdown
    markdown = \
'__Dropdown|Select Multiple|Red,Green,Blue|multiple__'

    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui multiple dropdown">
  <div class="default text">Select Multiple</div>
  <i class="dropdown icon"></i>
  <div class="menu">
    <div class="item">Red</div>
    <div class="item">Green</div>
    <div class="item">Blue</div>
  </div>
</div>
', output
  end

  def test_fluid_dropdown
    markdown = \
'__Dropdown|Fluid Selection|Item A,Item B,Item C|fluid__'

    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui fluid dropdown">
  <div class="default text">Fluid Selection</div>
  <i class="dropdown icon"></i>
  <div class="menu">
    <div class="item">Item A</div>
    <div class="item">Item B</div>
    <div class="item">Item C</div>
  </div>
</div>
', output
  end

  def test_loading_dropdown
    markdown = \
'__Dropdown|Loading...|Loading,Please wait|loading__'

    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui loading dropdown">
  <div class="default text">Loading...</div>
  <i class="dropdown icon"></i>
  <div class="menu">
    <div class="item">Loading</div>
    <div class="item">Please wait</div>
  </div>
</div>
', output
  end

  def test_error_dropdown
    markdown = \
'__Dropdown|Error State|Fix Error,Try Again|error__'

    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui error dropdown">
  <div class="default text">Error State</div>
  <i class="dropdown icon"></i>
  <div class="menu">
    <div class="item">Fix Error</div>
    <div class="item">Try Again</div>
  </div>
</div>
', output
  end

  def test_disabled_dropdown
    markdown = \
'__Dropdown|Disabled|Not Available|disabled__'

    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui disabled dropdown">
  <div class="default text">Disabled</div>
  <i class="dropdown icon"></i>
  <div class="menu">
    <div class="item">Not Available</div>
  </div>
</div>
', output
  end
end