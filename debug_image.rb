require_relative 'lib/markdown-ui'

puts 'Testing Image::Element...'
element = MarkdownUI::Image::Element.new(['Image'], 'https://example.com/image.png', 'circular')
puts 'Created element with:'
puts '  @element: ["Image"]'
puts '  @content: "https://example.com/image.png"'
puts '  @klass: "circular"'

result = element.render
puts 'Result: ' + result.inspect
