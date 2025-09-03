require 'redcarpet'
markdown = '> Item:
> ![Product](product.jpg)
> **Cute Dog**
> $22.99

> This is a very cute dog'

renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new)
redcarpet_output = renderer.render(markdown)
puts 'Redcarpet output:'
puts redcarpet_output.inspect

# Simulate what block_quote renderer does
clean_text = redcarpet_output.gsub(/<[^>]*>/, '').strip
puts ''
puts 'After HTML stripping:'
puts clean_text.inspect
