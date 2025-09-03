#!/usr/bin/env ruby

require_relative 'lib/markdown-ui'

puts "🔍 Individual Component Test"
puts "=" * 40

parser = MarkdownUI::Parser.new

# Test each new component individually
components = [
  { name: "Grid", markdown: "> Grid:\n> Basic grid content" },
  { name: "Segment", markdown: "> Segment:\n> Basic segment content" },
  { name: "Statistic", markdown: "> Statistic:\n> 123\n> Users" },
  { name: "Search", markdown: "> Search:\n> Search here..." },
  { name: "Feed", markdown: "> Feed:\n> Activity feed" },
  { name: "Loader", markdown: "> Loader:\n> Loading..." },
  { name: "Sidebar", markdown: "> Sidebar:\n> Menu items" },
]

components.each do |comp|
  puts "\n#{comp[:name]}:"
  puts "Input: #{comp[:markdown].inspect}"

  result = parser.render(comp[:markdown])
  puts "Output: #{result}"
  puts "Contains 'ui ': #{result.include?('ui ')}"
  puts "Contains component name: #{result.downcase.include?(comp[:name].downcase)}"
end