require './lib/markdown-ui'
parser = MarkdownUI::Parser.new
markdown = '> Image Card:
> ![Avatar](https://semantic-ui.com/images/avatar/large/matthew.png)
> **Matthew**
> Friend'
output = parser.parse(markdown)
puts 'Full parser output:'
puts output
