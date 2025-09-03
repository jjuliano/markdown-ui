require './lib/markdown-ui'
parser = MarkdownUI::Parser.new
markdown = '> Comments:
> > Comment:
> > ![User1](user1.jpg) **John**
> > This is great!
> > > Comment:
> > > ![User2](user2.jpg) **Jane**
> > > I agree!'
tokens = parser.instance_variable_get(:@tokenizer).tokenize(markdown)
puts 'Tokens:'
tokens.each do |token|
  puts '  Type: ' + token.type.to_s
  puts '  Element: ' + (token.element_name || 'nil')
  puts '  Content: ' + token.content.inspect
  puts ''
end
