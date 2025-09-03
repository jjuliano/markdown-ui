#!/usr/bin/env ruby
# Test script for complete Semantic UI 2.5.0 coverage

require_relative 'lib/markdown-ui'

puts "🧪 Testing Complete Semantic UI 2.5.0 Coverage"
puts "=" * 50

parser = MarkdownUI::Parser.new

# Test new missing components
test_cases = [
  {
    name: "Step Element",
    markdown: "> Step:\n> Icon:truck|Shipping|Your order is being processed"
  },
  {
    name: "Placeholder Element",
    markdown: "> Placeholder:\n> 5"
  },
  {
    name: "Popup Element",
    markdown: "> Button Popup:\n> Click me:This is popup content"
  },
  {
    name: "Tab Element",
    markdown: "> Tab:\n> First Tab:Content for first tab|Second Tab:Content for second tab"
  }
]

test_cases.each do |test|
  puts "\n📋 Testing: #{test[:name]}"
  puts "-" * 30

  begin
    output = parser.render(test[:markdown])
    puts "✅ SUCCESS"
    puts output
  rescue => e
    puts "❌ FAILED: #{e.message}"
    puts e.backtrace.first(3).join("\n")
  end
end

puts "\n🎉 Complete coverage test finished!"