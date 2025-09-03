require './lib/markdown-ui'
require './lib/markdown-ui/elements/comment_element'

# Test the comment element extract method
content = ['![Avatar](avatar.jpg) **Matt**\nHow artistic!']
element = MarkdownUI::Elements::CommentElement.new(content, [])

author, text, avatar = element.send(:extract_comment_content)
puts 'Author: ' + author.inspect
puts 'Text: ' + text.inspect  
puts 'Avatar: ' + avatar.inspect
