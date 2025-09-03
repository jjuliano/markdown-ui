#!/usr/bin/env ruby
require_relative 'lib/markdown-ui'

# Test deep blockquote nesting for all UI elements
puts "=== Testing Deep Blockquote Nesting ===\n"

test_cases = [
  {
    name: "Simple nesting (1 level)",
    markdown: '> Button: Primary Submit'
  },
  {
    name: "Basic nested elements (2 levels)",
    markdown: '> Segment: Basic
>> Button: Primary Submit'
  },
  {
    name: "Deep nested elements (3 levels)",
    markdown: '> Container: Text
>> Segment: Basic
>>> Button: Primary Submit'
  },
  {
    name: "Very deep nesting (4 levels)",
    markdown: '> Grid: Two Column
>> Column:
>>> Segment: Basic
>>>> Button: Primary Submit'
  },
  {
    name: "Complex nested structure (5 levels)",
    markdown: '> Modal: Basic
>> Header: Large
>>> Segment: Padded
>>>> Container: Text
>>>>> Button: Primary Submit'
  },
  {
    name: "Menu with deep nesting",
    markdown: '> Menu: Vertical Fluid
>> Item:
>>> Header: Small
>>>> Icon: User
>>>>> Button: Mini'
  },
  {
    name: "Form with deep nesting",
    markdown: '> Form: Basic
>> Field:
>>> Label: Username
>>>> Input: Text
>>>>> Button: Submit'
  },
  {
    name: "Accordion with deep nesting",
    markdown: '> Accordion: Styled
>> Title: Section 1
>>> Content:
>>>> Segment: Basic
>>>>> Button: Primary'
  },
  {
    name: "Card with deep nesting",
    markdown: '> Card:
>> Content:
>>> Header: Card Title
>>>> Meta: Created 2 days ago
>>>>> Description: Some description'
  },
  {
    name: "Table with deep nesting",
    markdown: '> Table: Basic
>> Header:
>>> Row:
>>>> Cell: Name
>>>>> Cell: Age'
  }
]

parser = MarkdownUI::Parser.new

test_cases.each do |test_case|
  puts "#{test_case[:name]}:"
  puts "Markdown:"
  puts test_case[:markdown]
  puts "\nHTML Output:"
  begin
    output = parser.parse(test_case[:markdown])
    puts output
  rescue StandardError => e
    puts "ERROR: #{e.message}"
  end
  puts "\n" + "="*50 + "\n"
end
