#!/usr/bin/env ruby
require_relative 'lib/markdown-ui'

# Simple test of the conversion
content = <<~MARKDOWN
> Container:
> > Segment:
> > # Test Page
> > 
> > This is a test of the markdown-ui conversion.
> > 
> > __Button|Click Me|primary__
MARKDOWN

parser = MarkdownUI::Parser.new
html_content = parser.render(content)

puts "Markdown-UI Content:"
puts content
puts "\n" + "="*50 + "\n"
puts "Generated HTML:"
puts html_content