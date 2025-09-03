# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/markdown-ui/parser'

class ArchitectureTest < Minitest::Test
  def setup
    @parser = MarkdownUI::Parser.new(beautify: true)
  end
  
  def test_table_parsing
    markdown = '__Table|Name,Age,Job|John,30,Developer|Jane,25,Designer|basic__'
    output = @parser.parse(markdown)
    
    assert_includes output, '<table class="ui basic table">'
    assert_includes output, '<thead>'
    assert_includes output, '<th>Name</th>'
    assert_includes output, '<th>Age</th>' 
    assert_includes output, '<th>Job</th>'
    assert_includes output, '<tbody>'
    assert_includes output, '<td>John</td>'
    assert_includes output, '<td>30</td>'
    assert_includes output, '<td>Developer</td>'
  end
  
  def test_animated_button_parsing
    markdown = '__Animated Button|Text:Next;Icon:Right Arrow__'
    output = @parser.parse(markdown)
    
    assert_includes output, '<div class="ui animated button">'
    assert_includes output, '<div class="visible content">Next</div>'
    assert_includes output, '<div class="hidden content">'
    assert_includes output, '<i class="right arrow icon"></i>'
  end
  
  def test_standard_button_parsing
    markdown = '__Button|Click Me|primary__'
    output = @parser.parse(markdown)
    
    assert_includes output, '<button class="ui primary button">'
    assert_includes output, 'Click Me'
  end
  
  def test_element_registry
    # Test that we can register custom elements
    custom_element_class = Class.new(MarkdownUI::Elements::BaseElement) do
      def render
        "<div class=\"#{css_class}\">Custom: #{@content}</div>"
      end
      
      def element_name
        'custom'
      end
    end
    
    @parser.register_element('custom', custom_element_class)
    
    markdown = '__Custom|Hello World|special__'
    output = @parser.parse(markdown)
    
    assert_includes output, '<div class="ui special custom">Custom: Hello World</div>'
  end
  
  def test_mixed_content
    markdown = "This is a __Button|Click Me|primary__ and a __Table|A,B|1,2|basic__ in text."
    output = @parser.parse(markdown)
    
    assert_includes output, 'This is a'
    assert_includes output, '<button class="ui primary button">Click Me</button>'
    assert_includes output, 'and a'
    assert_includes output, '<table class="ui basic table">'
    assert_includes output, 'in text.'
  end
  
  def test_error_handling
    # Test with invalid element
    markdown = '__NonexistentElement|content__'
    output = @parser.parse(markdown)
    
    # Should gracefully handle unknown elements (return nil, so it gets treated as text)
    assert_includes output, 'NonexistentElement'
  end
  
  def test_html_beautification
    parser_ugly = MarkdownUI::Parser.new(beautify: false)
    parser_pretty = MarkdownUI::Parser.new(beautify: true)
    
    markdown = '__Table|A,B|1,2__'
    
    ugly_output = parser_ugly.parse(markdown)
    pretty_output = parser_pretty.parse(markdown)
    
    # Pretty output should have newlines and indentation
    refute_includes ugly_output, "\n  <thead>"
    assert_includes pretty_output, "\n  <thead>"
  end
end