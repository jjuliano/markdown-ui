#!/usr/bin/env ruby
# frozen_string_literal: true

$DEBUG = true
require_relative 'lib/markdown-ui'

# Test the nested syntax pattern matching
test_content = "__Menu|\n  __Item|Home|active__\n  __Item|About__\n  __Item|Services__\n  __Item|Contact__\n__"

puts "Test content:"
puts test_content
puts "\nPattern match result:"
puts test_content.match?(/__(\w+.*?)__[\s\S]*?__$/m)

puts "\nRegex explanation:"
puts "Pattern: /__(w+.*?)__[\s\S]*?__$/"
puts "Should match:"
puts "- Opening: __Menu|"
puts "- Content: everything in between"
puts "- Closing: __"

# Test with markdown parser
markdown_ui = MarkdownUI::Parser.new(debug: true)

puts "\n\nParsing result:"
result = markdown_ui.parse(test_content)
puts result

# Test tokenization directly
puts "\n\nDirect tokenization test:"
tokenizer = MarkdownUI::Tokenizer.new
tokens = tokenizer.tokenize(test_content)
puts "Tokens found: #{tokens.length}"
tokens.each do |token|
  puts "Token: #{token.type} - #{token.element_name} - Content: #{token.content.inspect}"
end
