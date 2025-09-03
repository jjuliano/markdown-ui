#!/usr/bin/env ruby

require_relative "lib/markdown-ui"
parser = MarkdownUI::Parser.new

markdown = "> <!-- -->"
result = parser.parse(markdown)
puts "Comment result:"
puts result.inspect
