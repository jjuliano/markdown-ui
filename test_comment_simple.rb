require './lib/markdown-ui'
require './lib/markdown-ui/elements/comment_element'

# Test the comment element directly
content = ['test content']
element = MarkdownUI::Elements::CommentElement.new(content, [])
puts 'Element created successfully'
puts 'Content: ' + element.instance_variable_get(:@content).inspect
