#!/usr/bin/env ruby

ENV['RACK_ENV'] = 'test'
require_relative 'lib/markdown-ui'

# Test the header element directly
parser = MarkdownUI::Parser.new
tokenizer = MarkdownUI::Tokenizer.new

# Test simple header
markdown = "# Test Header"
result = parser.parse(markdown)
puts "Simple header result:"
puts result
puts "---"

# Test blockquote header
markdown2 = "> Header:"
puts "Blockquote header tokens:"
tokens2 = tokenizer.tokenize(markdown2)
tokens2.each { |token| puts "  #{token.inspect}" }
result2 = parser.parse(markdown2)
puts "Blockquote header result:"
puts result2
puts "---"

# Test more complex header
markdown3 = "> Header: Test|Sub"
result3 = parser.parse(markdown3)
puts "Complex header result:"
puts result3
