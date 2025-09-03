require './lib/markdown-ui'
parser = MarkdownUI::Parser.new
markdown = '> Image Card:
> ![Avatar](https://semantic-ui.com/images/avatar/large/matthew.png)
> **Matthew**
> Friend'
tokens = parser.instance_variable_get(:@tokenizer).tokenize(markdown)
puts 'Tokens:'
tokens.each do |token|
  puts '  Type: ' + token.type.to_s
  puts '  Element: ' + (token.element_name || 'nil').to_s
  puts '  Content: ' + token.content.inspect
  puts ''
end
