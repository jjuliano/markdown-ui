#!/usr/bin/env ruby
# frozen_string_literal: true

# Simple test script to verify HTML beautification works with htmlbeautifier

require_relative 'lib/markdown-ui/parser'

puts "Testing HTML beautification with htmlbeautifier..."

# Test basic HTML beautification
parser_ugly = MarkdownUI::Parser.new(beautify: false)
parser_pretty = MarkdownUI::Parser.new(beautify: true)

markdown = '__Table|A,B|1,2__'

ugly_output = parser_ugly.parse(markdown)
pretty_output = parser_pretty.parse(markdown)

puts "\n=== Ugly Output (beautify: false) ==="
puts ugly_output.inspect

puts "\n=== Pretty Output (beautify: true) ==="
puts pretty_output.inspect

# Check that both contain expected content
puts "\n=== Verification ==="
puts "Ugly contains 'ui table': #{ugly_output.include?('ui table')}"
puts "Pretty contains 'ui table': #{pretty_output.include?('ui table')}"
puts "Pretty has newlines: #{pretty_output.include?("\n")}"

# Test with a more complex example
puts "\n=== Testing with complex HTML ==="
complex_markdown = '__Button|Click Me|primary__\n\n__Segment|This is a segment|basic__'
complex_ugly = parser_ugly.parse(complex_markdown)
complex_pretty = parser_pretty.parse(complex_markdown)

puts "Complex ugly output:"
puts complex_ugly.inspect

puts "\nComplex pretty output:"
puts complex_pretty.inspect

puts "\nComplex pretty has more newlines: #{complex_pretty.count("\n") > complex_ugly.count("\n")}"

puts "\n=== Test Complete ==="
