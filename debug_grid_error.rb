#!/usr/bin/env ruby

require_relative 'lib/markdown-ui'

# Debug the Grid element directly
markdown = <<~MARKDOWN
> Grid:
> > # Greetings
> > > Row:
> > > > The quick brown fox
MARKDOWN

parser = MarkdownUI::Parser.new
tokenizer = parser.instance_variable_get(:@tokenizer)

# Get the tokens
tokens = tokenizer.tokenize(markdown)
puts "🔍 Grid Element Debug"
puts "=" * 50

tokens.each_with_index do |token, i|
  puts "Token #{i+1}:"
  puts "  Type: #{token.type}"
  puts "  Element: #{token.element_name}"
  puts "  Content: #{token.content.inspect}"
  puts "  Modifiers: #{token.modifiers.inspect}"
  puts
end

# Try to render the Grid element directly
if tokens.any? { |t| t.element_name == 'grid' }
  grid_token = tokens.find { |t| t.element_name == 'grid' }
  puts "Attempting to render Grid element directly..."

  begin
    grid_element = MarkdownUI::Elements::GridElement.new(
      grid_token.content,
      grid_token.modifiers,
      grid_token.attributes || {}
    )
    result = grid_element.render
    puts "Success!"
    puts result
  rescue => e
    puts "ERROR: #{e.class}: #{e.message}"
    puts "Backtrace:"
    puts e.backtrace.first(10)
  end
end