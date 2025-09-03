#!/usr/bin/env ruby

require_relative 'lib/markdown-ui'

# Test case for single button
markdown = '
> .klass#btn-id Button:
> _Right Arrow Icon_
> Follow
'

puts "=== INPUT ==="
puts markdown.inspect

tokenizer = MarkdownUI::Tokenizer.new
tokens = tokenizer.tokenize(markdown)

puts "\n=== TOKENS ==="
tokens.each_with_index do |token, i|
  puts "#{i}: type=#{token.type}, element_name=#{token.element_name}, modifiers=#{token.modifiers.inspect}"
  puts "    content=#{token.content.inspect}"
  puts
end

parser = MarkdownUI::Parser.new
result = parser.parse(markdown)

puts "\n=== RESULT ==="
puts result.inspect
puts "\n=== OUTPUT ==="
puts result