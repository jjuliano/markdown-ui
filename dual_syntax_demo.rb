#!/usr/bin/env ruby
# MarkdownUI Dual Syntax Demonstration
require_relative 'lib/markdown-ui/parser'

class DualSyntaxDemo
  def initialize
    @parser = MarkdownUI::Parser.new(beautify: true)
  end
  
  def run_demo
    puts "🔄 MarkdownUI: Dual Syntax Support Demo"
    puts "=" * 60
    puts
    puts "MarkdownUI supports TWO syntax patterns for maximum flexibility:"
    puts "1. 📝 INLINE SYNTAX: __Element|param1|param2|modifiers__"
    puts "2. 📦 CONTAINER SYNTAX: > Element:"
    puts "                       > content lines..."
    puts
    
    demo_inline_vs_container
    puts "\n" + "=" * 60 + "\n"
    demo_nested_containers
    puts "\n" + "=" * 60 + "\n"
    demo_complex_layouts
    puts "\n" + "=" * 60 + "\n"
    demo_mixed_syntax
  end
  
  private
  
  def demo_inline_vs_container
    puts "📝 INLINE vs 📦 CONTAINER: Same Results, Different Syntax"
    puts "-" * 60
    
    examples = [
      {
        name: "Grid Element",
        inline: '__Grid|Column 1|Column 2|Column 3|three column__',
        container: <<~MARKDOWN
          > Grid:
          > Column 1
          > Column 2
          > Column 3
        MARKDOWN
      },
      {
        name: "Segment Element", 
        inline: '__Segment|This is a segment with some content|raised__',
        container: <<~MARKDOWN
          > Segment:
          > This is a segment with some content
        MARKDOWN
      },
      {
        name: "Message Element",
        inline: '__Message|Success! Operation completed|success__',
        container: <<~MARKDOWN
          > Message:
          > Success! Operation completed
        MARKDOWN
      }
    ]
    
    examples.each do |example|
      puts "#{example[:name]}:"
      puts
      puts "  📝 INLINE SYNTAX:"
      puts "    #{example[:inline]}"
      puts "  → OUTPUT: #{@parser.parse(example[:inline]).gsub(/\n\s*/, ' ').strip}"
      puts
      puts "  📦 CONTAINER SYNTAX:"
      example[:container].lines.each { |line| puts "    #{line.chomp}" }
      puts "  → OUTPUT: #{@parser.parse(example[:container]).gsub(/\n\s*/, ' ').strip}"
      puts
      puts "-" * 40
    end
  end
  
  def demo_nested_containers
    puts "🏗️ NESTED CONTAINERS: Complex Layouts Made Easy"
    puts "-" * 60
    
    nested_markdown = <<~MARKDOWN
      > Grid:
      > This is column 1 with important content
      > This is column 2 with different content
      > This is column 3 with more content
    MARKDOWN
    
    puts "Example: Multi-column grid with container syntax"
    puts
    nested_markdown.lines.each { |line| puts "  #{line.chomp}" }
    puts
    result = @parser.parse(nested_markdown)
    puts "OUTPUT:"
    result.lines.each { |line| puts "  #{line.chomp}" }
  end
  
  def demo_complex_layouts
    puts "🎯 COMPLEX LAYOUTS: Real-world Examples"
    puts "-" * 60
    
    dashboard_markdown = <<~MARKDOWN
      > Container:
      > ## System Dashboard
      > 
      > This is a complete dashboard example using container syntax.
      > It supports multiple lines of content with proper formatting.
      
      > Segment:
      > ### Server Status
      > All systems are operational and running smoothly.
      > Last updated: #{Time.now.strftime('%Y-%m-%d %H:%M')}
    MARKDOWN
    
    puts "Example: Dashboard with multiple containers"
    puts
    dashboard_markdown.lines.each { |line| puts "  #{line.chomp}" }
    puts
    result = @parser.parse(dashboard_markdown)
    puts "OUTPUT:"
    result.lines.each { |line| puts "  #{line.chomp}" }
  end
  
  def demo_mixed_syntax
    puts "🔀 MIXED SYNTAX: Best of Both Worlds"
    puts "-" * 60
    
    mixed_markdown = <<~MARKDOWN
      __Header|Welcome to Our App|h1 blue__
      
      > Message:
      > ### Getting Started
      > Welcome! Here's how to use both syntax patterns effectively.
      > You can mix and match them as needed.
      
      __Progress|Setup Progress|75|indicating green__
      
      > Segment:
      > ## Available Features
      > - __Button|Try Inline|primary__ buttons work great inline
      > - Container elements use the > syntax for multi-line content
      > - __Label|New|green__ features are marked with labels
      
      __Button|Get Started|large primary__ __Button|Learn More|secondary__
    MARKDOWN
    
    puts "Example: Mixing both syntax patterns in one document"
    puts
    mixed_markdown.lines.each { |line| puts "  #{line.chomp}" unless line.strip.empty? }
    puts
    result = @parser.parse(mixed_markdown)
    puts "OUTPUT:"
    result.lines.each { |line| puts "  #{line.chomp}" unless line.strip.empty? }
  end
end

# Run the demo
if __FILE__ == $0
  demo = DualSyntaxDemo.new
  demo.run_demo
end