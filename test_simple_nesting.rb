#!/usr/bin/env ruby
require_relative 'lib/markdown-ui'

# Simple test for debugging nesting
parser = MarkdownUI::Parser.new

# Test 1: Simple nested elements
puts "=== Test 1: Simple nested elements ==="
markdown1 = '> Grid: Two Column
>> Column:
>>> Button: Primary Submit'

puts "Markdown:"
puts markdown1
puts "\nHTML Output:"
output1 = parser.parse(markdown1)
puts output1
puts "\n" + "="*50 + "\n"

# Test 2: Just the nested content alone
puts "=== Test 2: Just the nested content ==="
markdown2 = '>> Column:
>>> Button: Primary Submit'

puts "Markdown:"
puts markdown2
puts "\nHTML Output:"
output2 = parser.parse(markdown2)
puts output2
puts "\n" + "="*50 + "\n"

# Test 3: Even simpler - just the button
puts "=== Test 3: Just the button ==="
markdown3 = '> Button: Primary Submit'

puts "Markdown:"
puts markdown3
puts "\nHTML Output:"
output3 = parser.parse(markdown3)
puts output3
