require './lib/markdown-ui'
require './lib/markdown-ui/elements/comments_element'

# Test the comments element directly
content = ["Comment:\n![User1](user1.jpg) **John**\nThis is great!\n> Comment:\n> ![User2](user2.jpg) **Jane**\n> I agree!"]
element = MarkdownUI::Elements::CommentsElement.new(content, [])

puts 'Element created successfully'
puts 'Content: ' + element.instance_variable_get(:@content).inspect

result = element.render
puts 'Render result:'
puts result
