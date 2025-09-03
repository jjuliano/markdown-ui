require './lib/markdown-ui'
parser = MarkdownUI::Parser.new
markdown = '> Basic Buttons:
> __Button|One__
> __Button|Two__
> __Button|Three__
> ___
> Vertical Basic Buttons:
> __Button|One__
> __Button|Two__
> __Button|Three__'
tokens = parser.instance_variable_get(:@tokenizer).tokenize(markdown)
puts 'Tokens:'
tokens.each do |token|
  puts '  Type: ' + token.type.to_s
  puts '  Element: ' + (token.element_name || 'nil')
  puts '  Content: ' + token.content.inspect
  puts ''
end
