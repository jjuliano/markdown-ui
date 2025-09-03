#!/usr/bin/env ruby
# Simple test of the architecture without test framework dependencies

require_relative 'lib/markdown-ui/parser'

def test(description, &block)
  print "Testing #{description}... "
  begin
    result = block.call
    if result
      puts "✓ PASSED"
    else
      puts "✗ FAILED"
    end
  rescue => e
    puts "✗ ERROR: #{e.message}"
    puts e.backtrace.first(3)
  end
end

# Initialize parser
parser = MarkdownUI::Parser.new(beautify: false)

# Test 1: Basic table parsing
test "table parsing" do
  markdown = '__Table|Name,Age|John,30|basic__'
  output = parser.parse(markdown)
  puts "Output length: #{output.length}"
  puts "Full output: #{output.inspect}"
  output.include?('<table class="ui basic table">') &&
  output.include?('<th>') && output.include?('Name') &&
  output.include?('<td>') && output.include?('John')
end

# Test 2: Basic button parsing  
test "button parsing" do
  markdown = '__Button|Click Me|primary__'
  output = parser.parse(markdown)
  puts "Output: #{output}"
  output.include?('<button class="ui primary button">') &&
  output.include?('Click Me')
end

# Test 3: Animated button parsing
test "animated button parsing" do
  markdown = '__Animated Button|Text:Next;Icon:arrow__'
  output = parser.parse(markdown)
  puts "Output: #{output}"
  output.include?('<div class="ui') && output.include?('animated button">') &&
  output.include?('visible content') && output.include?('hidden content')
end

# Test 4: Element registry
test "element registry" do
  registered = parser.registered_elements
  puts "Registered elements: #{registered}"
  registered.include?('table') && registered.include?('button')
end

# Test 5: Mixed content
test "mixed content" do
  markdown = "Hello __Button|Click|primary__ world"
  output = parser.parse(markdown)
  puts "Output: #{output}"
  output.include?('Hello') && 
  output.include?('<button') && 
  output.include?('world')
end

puts "\nArchitecture Test Complete!"