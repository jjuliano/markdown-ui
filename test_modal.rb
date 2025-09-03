require_relative 'lib/markdown-ui'
parser = MarkdownUI::Parser.new
markdown = '> Image Modal:
> ![Modal Image](image.jpg)
> **Image Modal**

> This modal contains an image.'
output = parser.render(markdown)
puts 'Output:'
puts output
