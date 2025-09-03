#!/usr/bin/env ruby

require_relative 'lib/markdown-ui'

parser = MarkdownUI::Parser.new

puts "Testing New Default System"
puts "=" * 40

# Test basic elements
puts "Button test:"
button_test = "__Primary Button|Click Me__"
puts button_test
puts parser.parse(button_test)
puts

puts "Header test:"
header_test = "__Large Header|Welcome__"
puts header_test
puts parser.parse(header_test)
puts

puts "Message test:"
message_test = "__Success Message|Operation completed__"
puts message_test
puts parser.parse(message_test)
puts

puts "Registered elements: #{parser.registered_elements.join(', ')}"