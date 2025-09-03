require './lib/markdown-ui'
require './lib/markdown-ui/elements/comments_element'

# Test the comments element parsing
content = ["Comment:\n![User1](user1.jpg) **John**\nThis is great!\n> Comment:\n> ![User2](user2.jpg) **Jane**\n> I agree!"]
element = MarkdownUI::Elements::CommentsElement.new(content, [])

# Debug the parsing
content_str = element.send(:parse_comments_content)
puts 'Parsed content:'
puts content_str.inspect
