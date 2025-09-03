#!/usr/bin/env ruby

require_relative 'lib/markdown-ui'

# Test the new class and ID syntax
test_cases = [
  # Basic class syntax
  '__.my-class Button|Click Me__',
  # Multiple classes
  '__.btn.btn-primary.large Button|Primary Button__',
  # ID syntax
  '__#submit-btn Button|Submit__',
  # Both class and ID
  '__.my-class#my-id Button|Button with class and ID__',
  # Mixed with Semantic UI modifiers
  '__.custom-class.large#special-btn Primary Button|Special Button__',
  # Single underscore syntax
  '_.red-text#warning Button|Warning Button_',
  # Complex example
  '__.btn.btn-success#save-form.large Primary Button|Save Form__',
  # With segments
  '__.custom-segment#info-section Segment|This is a custom segment__'
]

puts "Testing Class and ID Syntax:"
puts "=" * 50

parser = MarkdownUI::Parser.new

test_cases.each do |test_case|
  puts "\nInput: #{test_case}"
  begin
    result = parser.parse(test_case)
    puts "Output: #{result.strip}"
  rescue StandardError => e
    puts "Error: #{e.message}"
  end
end
