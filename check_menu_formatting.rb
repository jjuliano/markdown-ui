require_relative 'lib/markdown-ui'
parser = MarkdownUI::Parser.new

# Test different menu types
menus = [
  ['> Three Item Menu:', '[Editorials](# "active")', '[Reviews](#)', '[Upcoming Events](#)'],
  ['> Pointing Menu:', '[Home](# "active")', '[Messages](#)', '[Friends](#)'],
  ['> Secondary Menu:', '[Home](#)', '[Messages](#)', '[Friends](#)']
]

menus.each do |menu_def|
  markdown = menu_def.join("\n")
  result = parser.render(markdown)
  puts "Menu: #{menu_def[0]}"
  puts "Result ends with newline: #{result.end_with?('\n')}"
  puts "Result (last 10 chars): #{result[-10..-1].inspect}"
  puts ""
end
