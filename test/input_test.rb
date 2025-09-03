# coding: UTF-8
require_relative 'test_helper'

class InputTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_standard_input
    markdown = '__Input|Enter your name__'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui input">
  <input type="text" placeholder="Enter your name" />
</div>
', output
  end

  def test_icon_input
    markdown = '__Input|Search...|icon search__'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui icon input">
  <input type="text" placeholder="Search..." />
  <i class="search icon"></i>
</div>
', output
  end

  def test_labeled_input
    markdown = '__Input|mysite.com|labeled http://__'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui labeled input">
  <div class="ui label">http://</div>
  <input type="text" placeholder="mysite.com" />
</div>
', output
  end

  def test_loading_input
    markdown = '__Input|Loading...|loading__'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui loading input">
  <input type="text" placeholder="Loading..." />
</div>
', output
  end

  def test_disabled_input
    markdown = '__Input|Disabled input|disabled__'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui disabled input">
  <input type="text" placeholder="Disabled input" disabled />
</div>
', output
  end

  def test_error_input
    markdown = '__Input|Invalid input|error__'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui error input">
  <input type="text" placeholder="Invalid input" />
</div>
', output
  end

  def test_focus_input
    markdown = '__Input|Focused input|focus__'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui focus input">
  <input type="text" placeholder="Focused input" />
</div>
', output
  end

  def test_transparent_input
    markdown = '__Input|Transparent input|transparent__'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui transparent input">
  <input type="text" placeholder="Transparent input" />
</div>
', output
  end

  def test_inverted_input
    markdown = '__Input|Inverted input|inverted__'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui inverted input">
  <input type="text" placeholder="Inverted input" />
</div>
', output
  end

  def test_fluid_input
    markdown = '__Input|Fluid input|fluid__'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui fluid input">
  <input type="text" placeholder="Fluid input" />
</div>
', output
  end

  def test_sized_inputs
    markdown_mini = '__Input|Mini input|mini__'
    output_mini = @parser.render(markdown_mini)
    assert_equal \
'<div class="ui mini input">
  <input type="text" placeholder="Mini input" />
</div>
', output_mini

    markdown_huge = '__Input|Huge input|huge__'
    output_huge = @parser.render(markdown_huge)
    assert_equal \
'<div class="ui huge input">
  <input type="text" placeholder="Huge input" />
</div>
', output_huge
  end
end