require './lib/markdown-ui'
parser = MarkdownUI::Parser.new
markdown = '> Comments:
> > Comment:
> > ![User1](user1.jpg) **John**
> > This is great!
> > > Comment:
> > > ![User2](user2.jpg) **Jane**
> > > I agree!'
output = parser.parse(markdown)
puts 'Threaded comments output:'
puts output
