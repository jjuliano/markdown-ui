require './lib/markdown-ui'

parser = MarkdownUI::Parser.new
markdown = '> Accordion:
> > Title: What is a dog?
> > Content: A dog is a type of domesticated animal.
> > Title: What kinds of dogs are there?
> > Content: There are many breeds of dogs. Each breed has unique characteristics.'

puts "INPUT MARKDOWN:"
puts markdown.inspect
puts "\nOUTPUT:"
output = parser.render(markdown)
puts output
