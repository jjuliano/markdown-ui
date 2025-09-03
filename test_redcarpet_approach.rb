#!/usr/bin/env ruby

require_relative 'lib/markdown-ui'

puts "🚀 Testing Redcarpet-Based Approach"
puts "=" * 50

# Your problematic nested example
markdown = <<~MARKDOWN
> Grid:
> > # Greetings
> > > Row:
> > > > The quick brown fox
MARKDOWN

puts "Input:"
puts markdown
puts

# Test with the new Redcarpet-based approach
parser = MarkdownUI::Parser.new

# First, test direct Redcarpet rendering
renderer = MarkdownUI::Renderers::UIAwareRenderer.new(element_registry: parser.instance_variable_get(:@element_registry))
redcarpet = Redcarpet::Markdown.new(renderer, autolink: true, tables: true, fenced_code_blocks: true)

puts "Direct Redcarpet UI-Aware Rendering:"
direct_result = redcarpet.render(markdown)
puts direct_result
puts

# Test security with dangerous content
puts "=" * 50
puts "Security Test:"

dangerous_markdown = <<~MARKDOWN
> Segment:
> <script>alert("xss")</script>
> > Button: Safe content
MARKDOWN

puts "Dangerous Input:"
puts dangerous_markdown
puts

security_result = redcarpet.render(dangerous_markdown)
puts "Output:"
puts security_result

if security_result.include?('<script')
  puts "❌ SECURITY RISK: Script tags not escaped!"
else
  puts "✅ SECURE: Script tags properly escaped"
end