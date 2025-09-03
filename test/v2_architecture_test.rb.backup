# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/markdown-ui/parser'

class ArchitectureTest < Test::Unit::TestCase
  def setup
    @parser = MarkdownUI::Parser.new(beautify: true)
  end
  
  def test_table_parsing
    markdown = '__Table|Name,Age,Job|John,30,Developer|Jane,25,Designer|basic__'
    output = @parser.parse(markdown)
    
    assert_includes output, 'ui basic table'
    assert_includes output, '<thead>'
    assert_includes output, 'Name'
    assert_includes output, 'Age' 
    assert_includes output, 'Job'
    assert_includes output, '<tbody>'
    assert_includes output, 'John'
    assert_includes output, '30'
    assert_includes output, 'Developer'
  end
  
  def test_animated_button_parsing
    markdown = '__Animated Button|Text:Next;Icon:Right Arrow__'
    output = @parser.parse(markdown)
    
    assert_includes output, 'ui fade animated button' # Default animation is fade
    assert_includes output, '<div class="visible content">'
    assert_includes output, '<div class="hidden content">'
    assert_includes output, '<i class="right arrow icon"></i>'
  end
  
  def test_standard_button_parsing
    markdown = '__Button|Click Me|primary__'
    output = @parser.parse(markdown)
    
    assert_includes output, 'ui primary button'
    assert_includes output, 'Click Me'
  end
  
  def test_element_registry
    # Test that we can register custom elements
    custom_element_class = Class.new(MarkdownUI::Elements::BaseElement) do
      def render
        content_str = @content.is_a?(Array) ? @content.join(' ') : @content.to_s
        "<div class=\"#{css_class}\">Custom: #{content_str}</div>"
      end
      
      def element_name
        'custom'
      end
    end
    
    @parser.register_element('custom', custom_element_class)
    
    markdown = '__Custom|Hello World|special__'
    output = @parser.parse(markdown)
    
    assert_includes output, 'ui custom'
    assert_includes output, 'Custom: Hello World'
  end
  
  def test_mixed_content
    markdown = "This is a __Button|Click Me|primary__ and a __Table|A,B|1,2|basic__ in text."
    output = @parser.parse(markdown)
    
    assert_includes output, 'This is a'
    assert_includes output, 'ui primary button'
    assert_includes output, 'Click Me'
    assert_includes output, 'and a'
    assert_includes output, 'ui basic table'
    assert_includes output, 'in text.'
  end
  
  def test_error_handling
    # Test with invalid element
    markdown = '__NonexistentElement|content__'
    output = @parser.parse(markdown)
    
    # Should gracefully handle unknown elements by returning empty string
    assert_equal '', output
  end
  
  def test_html_beautification
    parser_ugly = MarkdownUI::Parser.new(beautify: false)
    parser_pretty = MarkdownUI::Parser.new(beautify: true)
    
    markdown = '__Table|A,B|1,2__'
    
    ugly_output = parser_ugly.parse(markdown)
    pretty_output = parser_pretty.parse(markdown)
    
    # Both should contain table content, but pretty should have more newlines
    assert_includes ugly_output, 'ui table'
    assert_includes pretty_output, 'ui table'
    assert pretty_output.include?("\n"), "Pretty output should have newlines"
  end
end