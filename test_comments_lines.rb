require './lib/markdown-ui'
require './lib/markdown-ui/elements/comments_element'

# Test the comments element parsing
content = ["Comment:\n![User1](user1.jpg) **John**\nThis is great!\n> Comment:\n> ![User2](user2.jpg) **Jane**\n> I agree!"]
element = MarkdownUI::Elements::CommentsElement.new(content, [])

# Debug the lines
content_str = element.instance_variable_get(:@content)[0]
puts 'Raw content:'
puts content_str.inspect
puts ''

content_str = content_str.gsub(/\\n/, "\n").gsub(/\\"/, '"')
puts 'After unescaping:'
puts content_str.inspect
puts ''

lines = content_str.split("\n").map(&:strip).reject(&:empty?)
puts 'Lines:'
lines.each_with_index do |line, i|
  puts "  #{i}: #{line.inspect}"
end
