# coding: UTF-8
require_relative 'test_helper'

class DualSyntaxTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_shorthand_syntax_basic
    markdown = '__Label|Test Label__'
    output = @parser.parse(markdown)
    assert_equal '<div class="ui label">Test Label</div>', output
  end

  def test_shorthand_with_modifiers
    markdown = '__Basic Red Label|Important Notice__'
    output = @parser.parse(markdown)
    assert output.include?('ui basic red label')
    assert output.include?('Important Notice')
  end

  def test_button_shorthand
    markdown = '__Button|Click Me__'
    output = @parser.parse(markdown)
    assert output.include?('ui button')
    assert output.include?('Click Me')
  end

  def test_multiple_elements
    markdown = '__Label|First__ and __Button|Second__'
    output = @parser.parse(markdown)
    assert output.include?('ui label')
    assert output.include?('ui button')
    assert output.include?('First')
    assert output.include?('Second')
    assert output.include?('<p>and</p>')
  end

  def test_dual_syntax_compatibility
    # Test that both the shell and parser work together
    # This validates our dual syntax enhancement is compatible
    shorthand = '__Basic Label|Test__'
    output = @parser.parse(shorthand)
    assert output.include?('ui basic label')
    assert output.include?('Test')
  end

  def test_class_syntax_with_shorthand
    markdown = '__.custom-label#important-label Label|Important Label__'
    output = @parser.parse(markdown)
    assert output.include?('ui label custom-label')
    assert output.include?('id="important-label"')
    assert output.include?('Important Label')
  end

  def test_button_with_class_and_id
    markdown = '__.btn-primary#submit-btn Button|Submit Form__'
    output = @parser.parse(markdown)
    assert output.include?('ui button btn-primary')
    assert output.include?('id="submit-btn"')
    assert output.include?('Submit Form')
  end

  def test_multiple_classes_with_shorthand
    markdown = '__.label-info.label-large#status-label Label|Status Information__'
    output = @parser.parse(markdown)
    assert output.include?('ui label label-info label-large')
    assert output.include?('id="status-label"')
    assert output.include?('Status Information')
  end
end