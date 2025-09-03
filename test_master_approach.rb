#!/usr/bin/env ruby

require_relative 'lib/markdown-ui'

puts "🎯 Testing Master Branch Implementation"
puts "=" * 50

# Your problematic nested example
markdown = <<~MARKDOWN
> Grid:
> > # Greetings
> > > Row:
> > > > The quick brown fox
MARKDOWN

puts "Input:"
puts markdown
puts

# Test with the master branch approach
parser = MarkdownUI::Parser.new

begin
  result = parser.render(markdown)
  puts "Master Branch Output:"
  puts result
  puts

  # Check if > characters were preserved
  if result.include?('&gt;')
    puts "❌ FAIL: Contains &gt; - blockquotes were escaped"
  else
    puts "✅ PASS: No &gt; found - blockquotes preserved"
  end
rescue => e
  puts "❌ ERROR: #{e.class}: #{e.message}"
  puts "Backtrace:"
  puts e.backtrace.first(5)
end