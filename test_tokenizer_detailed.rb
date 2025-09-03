require './lib/markdown-ui'
parser = MarkdownUI::Parser.new
markdown = '> Image Card:
> ![Avatar](https://semantic-ui.com/images/avatar/large/matthew.png)
> **Matthew**
> Friend'
tokens = parser.instance_variable_get(:@tokenizer).tokenize(markdown)
tokens.each do |token|
  puts 'Element: ' + (token.element_name || 'nil')
  puts 'Modifiers: ' + token.modifiers.inspect
  puts 'Content: ' + token.content.inspect
end
