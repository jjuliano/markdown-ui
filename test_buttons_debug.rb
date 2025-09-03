require './lib/markdown-ui'
parser = MarkdownUI::Parser.new
markdown = '> Basic Buttons:
> __Button|One__
> __Button|Two__
> __Button|Three__'

# Let's manually trace the tokenizer logic
header_line = '> Basic Buttons:'
header_content = header_line.sub(/^>\s*/, '').sub(/:$/, '').strip
puts 'Header content: ' + header_content.inspect

header_parts = header_content.split(/\s+/)
puts 'Header parts: ' + header_parts.inspect

known_elements = %w[
  accordion advertisement breadcrumb button card checkbox comment container content
  dimmer divider dropdown embed feed field flag form grid header icon image input
  item label list loader menu message modal placeholder popup progress rail rating
  reveal search segment shape sidebar statistic step sticky tab table transition
]

puts 'Known elements include button? ' + known_elements.include?('button').to_s
puts 'Header parts include button? ' + header_parts.map(&:downcase).include?('button').to_s
