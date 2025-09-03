#!/usr/bin/env ruby

require_relative 'lib/markdown-ui/parser'

# Parse and render the complete demo
parser = MarkdownUI::Parser.new(beautify: true)

demo_content = File.read('complete_semantic_ui_demo.md')
result = parser.parse(demo_content)

puts "Complete Semantic UI Demo - Rendered Output"
puts "=" * 60
puts result

# Count elements found
ui_elements = result.scan(/class="ui\s+[^"]*"/).length
puts "\n" + "=" * 60
puts "Total UI elements rendered: #{ui_elements}"
puts "Parser has #{parser.registered_elements.count} registered elements"
puts "Demo completed successfully!"