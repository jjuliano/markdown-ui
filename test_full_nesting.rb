require './lib/markdown-ui'
require './lib/markdown-ui/elements/comments_element'

# Test the full parsing process
content = ["Comment:\n![User1](user1.jpg) **John**\nThis is great!\n> Comment:\n> ![User2](user2.jpg) **Jane**\n> I agree!"]
element = MarkdownUI::Elements::CommentsElement.new(content, [])

# Parse the content
content_str = element.instance_variable_get(:@content)[0]
content_str = content_str.gsub(/\\n/, "\n").gsub(/\\"/, '"')
lines = content_str.split("\n").map(&:strip).reject(&:empty?)

puts 'Lines:'
lines.each_with_index do |line, i|
  puts "  #{i}: #{line.inspect}"
end
puts ''

# Test parsing comment blocks
comments = element.send(:parse_comment_blocks, lines)
puts 'Parsed comments:'
comments.each_with_index do |comment, idx|
  puts "  Comment #{idx}:"
  puts "    Author: #{comment[:author]}"
  puts "    Text: #{comment[:text]}"
  puts "    Nesting level: #{comment[:nesting_level]}"
  puts "    Nested comments: #{comment[:nested_comments]&.length || 0}"
end
