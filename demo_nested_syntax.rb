#!/usr/bin/env ruby
# frozen_string_literal: true

# Demo script showcasing the nested syntax for Markdown-UI
# Run with: ruby demo_nested_syntax.rb

require_relative 'lib/markdown-ui'

puts "🎉 Markdown-UI Nested Syntax Demo"
puts "=" * 50

parser = MarkdownUI::Parser.new

# Demo 1: Basic Components
puts "\n📌 Demo 1: Basic Components"
puts "-" * 30

basic_markdown = <<~MARKDOWN
# Basic Components

__Button|Click Me__
__Primary Button|Save__
__Red Label|Important__
__Image|https://via.placeholder.com/100x100?text=Demo__
MARKDOWN

puts "Input:"
puts basic_markdown
puts "\nOutput:"
output = parser.parse(basic_markdown)
puts output

# Demo 2: Cards
puts "\n\n📌 Demo 2: Cards"
puts "-" * 30

card_markdown = <<~MARKDOWN
# Project Cards

__Card|
  __Header|Project Alpha__
  __Meta|Started 2 days ago__
  __Description|A comprehensive web application for task management.__
__

__Card|
  __Header|Mobile App__
  __Meta|Started 1 week ago__
  __Description|Cross-platform mobile application.__
__
MARKDOWN

puts "Input:"
puts card_markdown
puts "\nOutput:"
output = parser.parse(card_markdown)
puts output

# Demo 3: Menu
puts "\n\n📌 Demo 3: Navigation Menu"
puts "-" * 30

menu_markdown = <<~MARKDOWN
# Navigation

__Menu|
  __Item|Home|active__
  __Item|About__
  __Item|Services__
  __Item|Contact__
__
MARKDOWN

puts "Input:"
puts menu_markdown
puts "\nOutput:"
output = parser.parse(menu_markdown)
puts output

# Demo 4: Accordion
puts "\n\n📌 Demo 4: Accordion"
puts "-" * 30

accordion_markdown = <<~MARKDOWN
# FAQ Section

__Accordion|
  __Title|Getting Started__
  __Content|Welcome to our platform! Here's how to get started with our services.__
  __Title|Advanced Features__
  __Content|Learn about our advanced features, integrations, and API capabilities.__
  __Title|Support__
  __Content|Get help from our support team or browse our documentation.__
__
MARKDOWN

puts "Input:"
puts accordion_markdown
puts "\nOutput:"
output = parser.parse(accordion_markdown)
puts output

# Demo 5: Form
puts "\n\n📌 Demo 5: Form"
puts "-" * 30

form_markdown = <<~MARKDOWN
# Contact Form

__Form|
  __Field|
    __Label|Name__
    __Input|name|placeholder:Enter your name__
  __
  __Field|
    __Label|Email__
    __Input|email|type:email|placeholder:Enter your email__
  __
  __Field|
    __Label|Message__
    __Input|message|type:textarea|placeholder:Enter your message__
  __
  __Button|Send Message|primary__
__
MARKDOWN

puts "Input:"
puts form_markdown
puts "\nOutput:"
output = parser.parse(form_markdown)
puts output

# Demo 6: Table
puts "\n\n📌 Demo 6: Data Table"
puts "-" * 30

table_markdown = <<~MARKDOWN
# User Data

__Table|Name,Age,City,Role|John Doe,30,New York,Developer|Jane Smith,25,Los Angeles,Designer|Bob Johnson,35,Chicago,Manager__
MARKDOWN

puts "Input:"
puts table_markdown
puts "\nOutput:"
output = parser.parse(table_markdown)
puts output

# Demo 7: Mixed Syntax
puts "\n\n📌 Demo 7: Mixed Syntax Compatibility"
puts "-" * 30

mixed_markdown = <<~MARKDOWN
# Mixed Syntax Example

Traditional blockquote syntax:
> Button:
> Old Style Button

New nested syntax:
__Primary Button|Modern Button__

Traditional label:
> Label:
> Old Label

New label:
__Red Label|New Label__
MARKDOWN

puts "Input:"
puts mixed_markdown
puts "\nOutput:"
output = parser.parse(mixed_markdown)
puts output

# Demo 8: Progress and Status
puts "\n\n📌 Demo 8: Progress Indicators"
puts "-" * 30

progress_markdown = <<~MARKDOWN
# Project Status

Task Completion:
__Progress|75|active__

Database Migration:
__Progress|100|success__

File Upload:
__Progress|25|warning__
MARKDOWN

puts "Input:"
puts progress_markdown
puts "\nOutput:"
output = parser.parse(progress_markdown)
puts output

puts "\n" + "=" * 50
puts "🎊 Demo Complete!"
puts "\nThe nested syntax provides an intuitive way to create"
puts "complex UI components with clean, readable markdown."
puts "\nKey Benefits:"
puts "• Intuitive nested structure"
puts "• No recursion issues"
puts "• Full Semantic UI compatibility"
puts "• Backward compatible with existing syntax"
puts "• Comprehensive test coverage"
