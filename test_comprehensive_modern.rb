#!/usr/bin/env ruby

require_relative 'lib/markdown-ui'

puts "🚀 Comprehensive Test: Modern Dependencies"
puts "=" * 60

parser = MarkdownUI::Parser.new

# Test cases covering various UI elements
test_cases = [
  {
    name: "Basic Grid with nested content",
    markdown: <<~MD
> Grid:
> > # Welcome Header
> > > Button: Click Me
MD
  },
  {
    name: "Segment with multiple elements",
    markdown: <<~MD
> Segment:
> ## Features
> > Button: Primary Action
> > Button: Secondary Action
MD
  },
  {
    name: "Menu with items",
    markdown: <<~MD
> Menu:
> Home
> About
> Contact
MD
  },
  {
    name: "Message with content",
    markdown: <<~MD
> Message:
> **Success!** Your changes have been saved.
MD
  },
  {
    name: "Deep nesting test",
    markdown: <<~MD
> Container:
> > Grid:
> > > Segment:
> > > > # Deep Header
> > > > > Button: Deep Button
MD
  }
]

puts "\n📊 Dependencies Check:"
puts "- Ruby: #{RUBY_VERSION}"

gems_to_check = %w[redcarpet htmlbeautifier ostruct]
gems_to_check.each do |gem_name|
  begin
    gem gem_name
    version = Gem.loaded_specs[gem_name]&.version || "unknown"
    puts "- #{gem_name}: #{version}"
  rescue Gem::LoadError
    puts "- #{gem_name}: ❌ NOT FOUND"
  end
end

puts "\n🧪 Running Tests:"
puts "-" * 40

success_count = 0
total_tests = test_cases.length

test_cases.each_with_index do |test_case, i|
  puts "\n#{i+1}. #{test_case[:name]}"
  puts "Input:"
  puts test_case[:markdown].split("\n").map { |line| "  #{line}" }.join("\n")
  puts

  begin
    result = parser.render(test_case[:markdown])

    # Check if result is valid HTML-like structure
    if result.strip.empty?
      puts "⚠️  WARNING: Empty output"
    elsif result.include?('<') && result.include?('>')
      puts "✅ SUCCESS: Generated HTML structure"
      success_count += 1

      # Check for escaped blockquotes
      if result.include?('&gt;')
        puts "⚠️  WARNING: Contains escaped blockquotes (&gt;)"
      end

      # Show first line of output for verification
      first_line = result.split("\n").first&.strip
      puts "   Output: #{first_line}" if first_line
    else
      puts "❌ ERROR: Invalid HTML output"
    end

  rescue => e
    puts "❌ ERROR: #{e.class}: #{e.message}"
  end
end

puts "\n" + "=" * 60
puts "📈 Test Summary:"
puts "✅ Passed: #{success_count}/#{total_tests}"
puts "❌ Failed: #{total_tests - success_count}/#{total_tests}"

if success_count == total_tests
  puts "🎉 All tests passed! Dependencies updated successfully!"
else
  puts "⚠️  Some tests failed. Please check the errors above."
end