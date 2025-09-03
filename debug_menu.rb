#!/usr/bin/env ruby

content_str = "[Inbox __Div Tag|1|Teal Pointing Left Label__](# \"active teal item\")\n[Spam __Div Tag|51|Label__](#)\n[Updates __Div Tag|1|Label__](#)"

puts 'Content string:'
puts content_str.inspect
puts ''
puts 'Contains |:', content_str.include?('|')
puts 'Contains ](:', content_str.include?('](')
puts 'Condition result:', content_str.include?('|') && !content_str.include?('](')

if content_str.include?('|') && !content_str.include?('](')
  puts 'Splitting by |'
  result = content_str.split('|').map(&:strip).reject(&:empty?)
  puts 'Result:', result.inspect
elsif content_str.include?(',')
  puts 'Splitting by ,'
elsif content_str.include?("\n") || content_str.include?("\\n")
  puts 'Splitting by newlines'
  content_with_newlines = content_str.gsub(/\\n/, "\n")
  result = content_with_newlines.split("\n").map(&:strip).reject(&:empty?)
  puts 'Result:', result.inspect
end
