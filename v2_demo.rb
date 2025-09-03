#!/usr/bin/env ruby
# MarkdownUI Architecture Demonstration
require_relative 'lib/markdown-ui/parser'

class Demo
  def initialize
    @parser = MarkdownUI::Parser.new(beautify: true)
  end
  
  def run_demo
    puts "🚀 MarkdownUI Architecture Demo"
    puts "=" * 50
    puts
    
    demo_basic_elements
    puts "\n" + "=" * 50 + "\n"
    demo_form_elements  
    puts "\n" + "=" * 50 + "\n"
    demo_layout_elements
    puts "\n" + "=" * 50 + "\n"
    demo_data_elements
    puts "\n" + "=" * 50 + "\n"
    demo_interactive_elements
    puts "\n" + "=" * 50 + "\n"
    demo_complete_dashboard
  end
  
  private
  
  def demo_basic_elements
    puts "📝 BASIC ELEMENTS"
    puts "-" * 20
    
    examples = [
      ['Button', '__Button|Click Me|primary large__'],
      ['Header', '__Header|Welcome|h2 blue__'],
      ['Message', '__Message|Success! Your data has been saved.|success__'],
      ['Divider', '__Divider|Section Break__'],
      ['Icon', '__Icon|star|yellow huge__']
    ]
    
    examples.each do |name, markdown|
      puts "#{name}:"
      puts @parser.parse(markdown)
      puts
    end
  end
  
  def demo_form_elements
    puts "📋 FORM ELEMENTS"  
    puts "-" * 20
    
    examples = [
      ['Input Field', '__Input|Enter your email|email__'],
      ['Dropdown', '__Dropdown|Select Country|USA|Canada|UK|France__'],
      ['Checkbox', '__Checkbox|I agree to terms|checked__'],
      ['Field Label', '__Field|Email Address|required__'],
      ['Progress Bar', '__Progress|Upload Progress|75|indicating green__']
    ]
    
    examples.each do |name, markdown|
      puts "#{name}:"
      puts @parser.parse(markdown)
      puts
    end
  end
  
  def demo_layout_elements
    puts "🏗️ LAYOUT ELEMENTS"
    puts "-" * 20
    
    examples = [
      ['Container', '__Container|This content is contained|text__'],
      ['Segment', '__Segment|This is a content segment|raised__'],
      ['Grid', '__Grid|Column 1|Column 2|Column 3|three column__'],
      ['Breadcrumb', '__Breadcrumb|Home > Products > Details__']
    ]
    
    examples.each do |name, markdown|
      puts "#{name}:"
      puts @parser.parse(markdown)
      puts
    end
  end
  
  def demo_data_elements
    puts "📊 DATA ELEMENTS"
    puts "-" * 20
    
    examples = [
      ['Table', '__Table|Name,Status,Score|John,Active,95|Jane,Inactive,87|striped celled__'],
      ['List', '__List|First item|Second item|Third item|bulleted__'],
      ['Label', '__Label|New Feature|green tag__'],
      ['Flag', '__Flag|us__']
    ]
    
    examples.each do |name, markdown|
      puts "#{name}:"
      puts @parser.parse(markdown)
      puts
    end
  end
  
  def demo_interactive_elements
    puts "⚡ INTERACTIVE ELEMENTS"
    puts "-" * 20
    
    examples = [
      ['Accordion', '__Accordion|FAQ 1:This is the answer to question 1|FAQ 2:This is the answer to question 2__'],
      ['Menu', '__Menu|Home|Products|About|Contact|secondary__'],
      ['Modal', '__Modal|Confirmation|Are you sure you want to delete?__'],
      ['Popup', '__Popup|Help|Click for more information|button__']
    ]
    
    examples.each do |name, markdown|
      puts "#{name}:"
      puts @parser.parse(markdown)
      puts
    end
  end
  
  def demo_complete_dashboard
    puts "🎯 COMPLETE DASHBOARD EXAMPLE"
    puts "-" * 30
    
    dashboard_markdown = <<~MARKDOWN
      __Header|System Dashboard|h1 blue__
      
      __Progress|System Health|92|indicating success green__
      __Progress|Memory Usage|67|indicating yellow__
      __Progress|Disk Usage|34|indicating blue__
      
      __Table|Service,Status,Uptime|Web Server,__Label|Online|green__,99.9%|Database,__Label|Online|green__,99.8%|Cache,__Label|Warning|yellow__,95.2%|striped celled__
      
      __Menu|Overview|Reports|Settings|Users|secondary__
      
      __Message|System Status: All services are operational. Next maintenance: Saturday 2:00 AM|info__
      
      __Button|Refresh Data|primary__ __Button|Export Report|secondary__ __Button|System Settings|basic__
    MARKDOWN
    
    result = @parser.parse(dashboard_markdown)
    puts result
  end
end

# Run the demo
if __FILE__ == $0
  demo = Demo.new
  demo.run_demo
end