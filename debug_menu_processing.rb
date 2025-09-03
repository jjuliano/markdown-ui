#!/usr/bin/env ruby

# Let's trace through the menu processing step by step
items = [
  '[Inbox __Div Tag|1|Teal Pointing Left Label__](# "active teal item")',
  '[Spam __Div Tag|51|Label__](#)',
  '[Updates __Div Tag|1|Label__](#)'
]

puts 'Original items:'
items.each_with_index { |item, i| puts "  #{i}: '#{item}'" }
puts ''

# Test the pattern matching for each item
pattern = /^\[.*\]\(.*\)/

puts 'Pattern matching:'
items.each_with_index do |item, i|
  matches_markdown = item.match?(pattern)
  matches_start_gt = item.match?(/^>/)
  should_parse = matches_markdown && !matches_start_gt
  
  puts "Item #{i + 1}:"
  puts "  Content: '#{item}'"
  puts "  Matches markdown pattern: #{matches_markdown}"
  puts "  Starts with >: #{matches_start_gt}"
  puts "  Should parse: #{should_parse}"
  puts ''
end
