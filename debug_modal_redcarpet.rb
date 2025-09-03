require 'redcarpet'
markdown = '> Image Modal:
> ![Modal Image](image.jpg)
> **Image Modal**

> This modal contains an image.'
renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new)
result = renderer.render(markdown)
puts 'Redcarpet output:'
puts result
