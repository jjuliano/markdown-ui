require 'redcarpet'

# Create a custom renderer to see all the calls
class DebugRenderer < Redcarpet::Render::HTML
  def block_quote(text)
    puts 'REDCARPET block_quote called with: ' + text.inspect
    super
  end

  def paragraph(text)
    puts 'REDCARPET paragraph called with: ' + text.inspect
    super
  end

  def image(link, title, alt_text)
    puts 'REDCARPET image called with: ' + [link, title, alt_text].inspect
    super
  end

  def emphasis(text)
    puts 'REDCARPET emphasis called with: ' + text.inspect
    super
  end
end

markdown = '> Item:
> ![Product](product.jpg)
> **Cute Dog**
> $22.99

> This is a very cute dog'

renderer = Redcarpet::Markdown.new(DebugRenderer.new)
result = renderer.render(markdown)
puts 'Final result: ' + result.inspect
