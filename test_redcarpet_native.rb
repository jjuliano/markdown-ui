#!/usr/bin/env ruby

require 'redcarpet'

puts "🔍 Testing Redcarpet's Native Blockquote Handling"
puts "=" * 60

# Your deeply nested example
markdown = <<~MARKDOWN
> Grid:
> > # Greetings
> > > Row:
> > > > The quick brown fox
MARKDOWN

puts "Input:"
puts markdown
puts

# Test Redcarpet's default blockquote handling
renderer = Redcarpet::Render::HTML.new
redcarpet = Redcarpet::Markdown.new(renderer, autolink: true, tables: true, fenced_code_blocks: true)

puts "Redcarpet Default Output:"
result = redcarpet.render(markdown)
puts result
puts

# Test with custom renderer that preserves blockquote structure
custom_renderer = Class.new(Redcarpet::Render::HTML) do
  def initialize(options={})
    super(options)
    @nesting_level = 0
  end

  def block_quote(quote)
    @nesting_level += 1
    content = quote.strip

    # Check if this blockquote contains UI element syntax
    if content.match?(/^\s*\w+.*:\s*$/) || content.match?(/^\s*\w+.*:\s*\n/)
      # This looks like UI element syntax
      lines = content.split("\n")
      first_line = lines.first.strip

      if first_line.match?(/^(\w+.*?):\s*(.*)$/)
        element_name = $1.downcase.strip
        remaining_content = lines[1..-1]&.join("\n") || ""

        # Generate UI element
        <<~HTML
<div class="ui #{element_name}" data-nesting="#{@nesting_level}">
#{remaining_content.empty? ? '' : remaining_content}
</div>
        HTML
      else
        # Regular blockquote
        "<blockquote>#{content}</blockquote>"
      end
    else
      # Regular blockquote
      "<blockquote>#{content}</blockquote>"
    end
  ensure
    @nesting_level -= 1 if @nesting_level > 0
  end
end.new

custom_redcarpet = Redcarpet::Markdown.new(custom_renderer, autolink: true, tables: true, fenced_code_blocks: true)

puts "Custom UI-Aware Redcarpet Output:"
custom_result = custom_redcarpet.render(markdown)
puts custom_result