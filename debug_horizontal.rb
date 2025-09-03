#!/usr/bin/env ruby

require_relative 'lib/markdown-ui'

parser = MarkdownUI::Parser.new

markdown = %q{
> Center Aligned Basic Segment:
> > Left Icon Action Input:
> > _Search Icon_
> > __Input|Text|Order #__
> > __Blue Submit Button|Search__

> <!-- -->

> > Horizontal Divider:
> > Or

> <!-- -->

> __Teal Labeled Icon Button|Create New Order, Icon: Add Icon__
}

puts "Input markdown:"
puts markdown
puts "\nOutput:"
output = parser.parse(markdown)
puts output.inspect
