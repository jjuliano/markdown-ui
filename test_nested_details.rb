require './lib/markdown-ui'
require './lib/markdown-ui/elements/comments_element'

# Test the nested comment details
content = ["Comment:\n![User1](user1.jpg) **John**\nThis is great!\n> Comment:\n> ![User2](user2.jpg) **Jane**\n> I agree!"]
element = MarkdownUI::Elements::CommentsElement.new(content, [])

# Parse the content
content_str = element.instance_variable_get(:@content)[0]
content_str = content_str.gsub(/\\n/, "\n").gsub(/\\"/, '"')
lines = content_str.split("\n").map(&:strip).reject(&:empty?)

comments = element.send(:parse_comment_blocks, lines)

puts 'Root comments:'
comments.each_with_index do |comment, idx|
  puts "  Comment #{idx}:"
  puts "    Author: #{comment[:author]}"
  puts "    Text: #{comment[:text]}"
  puts "    Nested comments: #{comment[:nested_comments]&.length || 0}"
  
  if comment[:nested_comments]
    comment[:nested_comments].each_with_index do |nested, nidx|
      puts "      Nested #{nidx}:"
      puts "        Author: #{nested[:author]}"
      puts "        Text: #{nested[:text]}"
    end
  end
end
