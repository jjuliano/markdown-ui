#!/usr/bin/env ruby

require_relative 'lib/markdown-ui'

# Test the broken nested blockquote example
markdown = <<~MARKDOWN
> Grid:
> > # Greetings
> > > Row:
> > > > The quick brown fox
MARKDOWN

puts "🔍 Testing broken nested blockquote example"
puts "=" * 50
puts "Input:"
puts markdown
puts
puts "=" * 50

parser = MarkdownUI::Parser.new
result = parser.render(markdown)

puts "Output:"
puts result
puts
puts "=" * 50
puts "🐛 Problem: Notice how the nested > characters become &gt;"
puts "This breaks the hierarchical blockquote structure you intended."