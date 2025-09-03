require_relative 'lib/markdown-ui'
parser = MarkdownUI::Parser.new
markdown = '> Item:
> ![Product](product.jpg)
> **Cute Dog**
> $22.99

> This is a very cute dog'
output = parser.render(markdown)
puts 'Output:'
puts output
