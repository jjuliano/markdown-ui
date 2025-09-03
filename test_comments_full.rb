require './lib/markdown-ui'
require './lib/markdown-ui/elements/comments_element'

# Test the comments element parsing
content = ["Comment:\n![User1](user1.jpg) **John**\nThis is great!\n> Comment:\n> ![User2](user2.jpg) **Jane**\n> I agree!"]
element = MarkdownUI::Elements::CommentsElement.new(content, [])

# Debug the parsing
content_str = element.instance_variable_get(:@content)[0]
content_str = content_str.gsub(/\\n/, "\n").gsub(/\\"/, '"')
lines = content_str.split("\n").map(&:strip).reject(&:empty?)

puts 'All lines:'
lines.each_with_index do |line, i|
  puts "  #{i}: #{line.inspect}"
end
puts ''

# Test parsing
comments = element.send(:parse_comment_blocks, lines)
puts 'Parsed comments:'
comments.each do |comment|
  puts "  Comment:"
  puts "    Avatar: #{comment[:avatar].inspect}"
  puts "    Author: #{comment[:author].inspect}"
  puts "    Text: #{comment[:text].inspect}"
  puts "    End index: #{comment[:end_index]}"
end
