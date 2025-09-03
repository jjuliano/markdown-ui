#!/usr/bin/env ruby

require_relative 'lib/markdown-ui'

# Test case for fitted divider
markdown = '
> Segment:
> "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros. Nullam malesuada erat ut turpis. Suspendisse urna nibh, viverra non, semper suscipit, posuere a, pede."
> > Fitted Divider:
> > &nbsp;
>
> Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros. Nullam malesuada erat ut turpis. Suspendisse urna nibh, viverra non, semper suscipit, posuere a, pede.
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