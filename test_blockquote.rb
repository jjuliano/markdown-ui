#!/usr/bin/env ruby
require_relative 'lib/markdown-ui'

# Test the exact markdown from the working button test
markdown = '
> Klass Button:
> Follow
'

parser = MarkdownUI::Parser.new
output = parser.parse(markdown)
puts "Output: #{output.inspect}"
puts "HTML:"
puts output