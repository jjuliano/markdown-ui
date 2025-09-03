#!/usr/bin/env ruby

require_relative 'lib/markdown-ui'

puts "🧪 Testing Nested Blockquotes Across All Elements"
puts "=" * 60

parser = MarkdownUI::Parser.new

# Test cases for different elements
test_cases = [
  {
    name: "Segment with nested content",
    markdown: <<~MD
> Segment:
> > # Nested Header
> > > Message:
> > > > Success! The operation completed.
MD
  },
  {
    name: "Message with nested button",
    markdown: <<~MD
> Message:
> > # Alert
> > > Button:
> > > > Click Here
MD
  },
  {
    name: "Container with deep nesting",
    markdown: <<~MD
> Container:
> > Header: Welcome
> > > Segment:
> > > > # Main Content
> > > > > Label:
> > > > > > Important
MD
  }
]

test_cases.each_with_index do |test_case, i|
  puts "\n#{i+1}. #{test_case[:name]}"
  puts "-" * 40
  puts "Input:"
  puts test_case[:markdown]
  puts
  puts "Output:"

  begin
    result = parser.parse(test_case[:markdown])
    puts result

    # Check if > characters were preserved
    if result.include?('&gt;')
      puts "❌ FAIL: Contains &gt; - blockquotes were escaped"
    else
      puts "✅ PASS: No &gt; found - blockquotes preserved"
    end
  rescue => e
    puts "❌ ERROR: #{e.class}: #{e.message}"
  end

  puts
end