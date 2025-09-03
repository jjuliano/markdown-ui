require './lib/markdown-ui'
parser = MarkdownUI::Parser.new
markdown = '> Cards:
> > Card:
> > **Card 1**
> > First card
> > Card:
> > **Card 2**
> > Second card'
tokens = parser.instance_variable_get(:@tokenizer).tokenize(markdown)
puts 'Tokens:'
tokens.each do |token|
  puts '  Type: ' + token.type.to_s
  puts '  Element: ' + (token.element_name || 'nil')
  puts '  Content: ' + token.content.inspect
  puts ''
end
