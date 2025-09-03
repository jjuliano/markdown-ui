require './lib/markdown-ui'
parser = MarkdownUI::Parser.new
markdown = '> Comment:
> ![Avatar](avatar.jpg) **Matt**
> How artistic!'
tokens = parser.instance_variable_get(:@tokenizer).tokenize(markdown)
puts 'Tokens:'
tokens.each do |token|
  puts '  Type: ' + token.type.to_s
  puts '  Element: ' + (token.element_name || 'nil')
  puts '  Content: ' + token.content.inspect
end
