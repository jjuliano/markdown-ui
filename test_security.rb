#!/usr/bin/env ruby

require_relative 'lib/markdown-ui'

puts "🔒 Security Test: Ensure dangerous HTML is still escaped"
puts "=" * 60

parser = MarkdownUI::Parser.new

# Test cases with potentially dangerous content
test_cases = [
  {
    name: "Script tag injection",
    markdown: '<script>alert("xss")</script>'
  },
  {
    name: "HTML tag injection",
    markdown: '<div onclick="alert()">Click</div>'
  },
  {
    name: "Mixed blockquote + dangerous HTML",
    markdown: <<~MD
> Segment:
> <script>alert("xss")</script>
> > Button: <img src="x" onerror="alert()">
MD
  },
  {
    name: "Greater than in regular content",
    markdown: '5 > 3 and 10 > 5'
  }
]

test_cases.each_with_index do |test_case, i|
  puts "\n#{i+1}. #{test_case[:name]}"
  puts "-" * 40
  puts "Input: #{test_case[:markdown].inspect}"

  result = parser.parse(test_case[:markdown])
  puts "Output: #{result}"

  # Security checks
  if result.include?('<script')
    puts "❌ SECURITY RISK: <script> tag not escaped!"
  else
    puts "✅ SECURE: <script> tags properly escaped"
  end

  if result.include?('onerror=')
    puts "❌ SECURITY RISK: onerror attribute not escaped!"
  else
    puts "✅ SECURE: Dangerous attributes escaped"
  end

  puts
end