require './lib/markdown-ui'
require './lib/markdown-ui/elements/comments_element'

# Test nesting level counting
element = MarkdownUI::Elements::CommentsElement.new([], [])

test_lines = ["Comment:", "> Comment:", ">> Comment:"]
test_lines.each do |line|
  level = element.send(:count_nesting_level, line)
  puts "#{line.inspect} -> level #{level}"
end
