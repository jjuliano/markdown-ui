#!/usr/bin/env ruby

require_relative 'lib/markdown-ui'

# Debug the tokenizer with the broken nested example
markdown = <<~MARKDOWN
> Grid:
> > # Greetings
> > > Row:
> > > > The quick brown fox
MARKDOWN

puts "🔍 Tokenizer Debug for Nested Blockquotes"
puts "=" * 50
puts "Input:"
puts markdown
puts

parser = MarkdownUI::Parser.new
tokenizer = parser.instance_variable_get(:@tokenizer)

tokens = tokenizer.tokenize(markdown)

puts "=" * 50
puts "Tokenizer Output:"
tokens.each_with_index do |token, i|
  puts "#{i+1}. Type: #{token.type}"
  puts "   Element: #{token.element_name || 'nil'}"
  puts "   Content: #{token.content.inspect}"
  puts "   Modifiers: #{token.modifiers.inspect}"
  puts
end

puts "=" * 50
puts "🐛 Analysis:"
puts "The tokenizer should see this as:"
puts "1. Grid element with nested content"
puts "2. Nested header (# Greetings) inside Grid"
puts "3. Nested Row element inside Grid"
puts "4. Content 'The quick brown fox' inside Row"