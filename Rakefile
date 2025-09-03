# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

# Test task
Rake::TestTask.new(:test) do |t|
  t.libs << "lib"
  t.libs << "test"
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
end

# Default task
task default: :test

# Lint task (if available)
begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
rescue LoadError
  # RuboCop not available
end

# MarkdownUI specific tasks
namespace :markdown_ui do
  desc "Show version information"
  task :version do
    require_relative 'lib/markdown-ui/version'
    puts "MarkdownUI version: #{MarkdownUI::VERSION}"
  end

  desc "List all available UI elements"
  task :elements do
    require_relative 'lib/markdown-ui'
    parser = MarkdownUI::Parser.new
    elements = parser.registered_elements
    
    puts "Available UI Elements (#{elements.count}):"
    puts "=" * 40
    elements.each { |element| puts "  #{element}" }
    puts ""
    puts "Usage: __Element Name|content|modifiers__"
  end

  desc "Test basic functionality"
  task :smoke_test do
    require_relative 'lib/markdown-ui'
    
    parser = MarkdownUI::Parser.new
    
    # Test basic elements
    tests = [
      "__Button|Test Button__",
      "__Large Header|Test Header__", 
      "__Success Message|Test Message__"
    ]
    
    puts "Running smoke tests..."
    tests.each do |test|
      result = parser.parse(test)
      if result && result.include?('ui')
        puts "✓ #{test} -> OK"
      else
        puts "✗ #{test} -> FAILED"
        exit 1
      end
    end
    puts "All smoke tests passed!"
  end

  desc "Generate example HTML file"
  task :example do
    require_relative 'lib/markdown-ui'
    
    markdown_content = <<~MARKDOWN
      # MarkdownUI Example
      
      This demonstrates the MarkdownUI system with complete Semantic UI coverage.
      
      ## Basic Elements
      
      __Primary Button|Get Started__
      
      __Large Header|Amazing Features__
      
      __Success Message|Everything is working perfectly!__
      
      ## Advanced Elements
      
      __Striped Table|Name,Age,City|John,25,NYC|Jane,30,LA__
      
      __4 Star Rating|4/5__
      
      __Active Dimmer|Loading content...__
      
      Generated with MarkdownUI - #{Time.now}
    MARKDOWN
    
    parser = MarkdownUI::Parser.new(beautify: true)
    html_content = parser.parse(markdown_content)
    
    # Generate full HTML document
    full_html = <<~HTML
      <!DOCTYPE html>
      <html lang="en">
        <head>
          <meta charset="utf-8">
          <meta name="viewport" content="width=device-width, initial-scale=1">
          <title>MarkdownUI Example</title>
          <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.5.0/semantic.min.css">
          <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.5.0/semantic.min.js"></script>
          <style>
            body { padding: 2rem; }
            .ui.container { max-width: none !important; }
          </style>
        </head>
        <body>
          <div class="ui container">
            #{html_content}
          </div>
          <script>
            $(document).ready(function() {
              $('.ui.dropdown').dropdown();
              $('.ui.modal').modal();
              $('.ui.accordion').accordion();
            });
          </script>
        </body>
      </html>
    HTML
    
    File.write('example.html', full_html)
    puts "Generated example.html"
    puts "Open in browser to see MarkdownUI in action!"
  end

  desc "Clean up generated files"
  task :clean do
    files_to_clean = ['example.html', 'test.html', '*.tmp']
    files_to_clean.each do |pattern|
      Dir.glob(pattern).each do |file|
        File.delete(file)
        puts "Deleted #{file}"
      end
    end
  end
end

# Add convenience aliases
task elements: 'markdown_ui:elements'
task version: 'markdown_ui:version'
task smoke: 'markdown_ui:smoke_test'
task example: 'markdown_ui:example'