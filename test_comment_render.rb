require './lib/markdown-ui'
require './lib/markdown-ui/elements/comment_element'

# Test the comment element render method
content = ['![Avatar](avatar.jpg) **Matt**\nHow artistic!']
element = MarkdownUI::Elements::CommentElement.new(content, [])

result = element.render
puts 'Render result:'
puts result
