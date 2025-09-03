require_relative 'lib/markdown-ui'
parser = MarkdownUI::Parser.new

markdown = '> Pointing Menu:
> [Home](# "active")
> [Messages](#)
> [Friends](#)'

result = parser.render(markdown)
puts 'Pointing Menu Result:'
puts result.inspect
puts ''
puts 'Expected:'
expected = '<div class="ui pointing menu">
  <a class="ui active item" href="#">Home</a>
  <a class="ui item" href="#">Messages</a>
  <a class="ui item" href="#">Friends</a>
</div>'
puts expected.inspect
