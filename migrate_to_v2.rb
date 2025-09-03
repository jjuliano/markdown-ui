#!/usr/bin/env ruby
# frozen_string_literal: true

# Migration script to update MarkdownUI references
require_relative 'lib/markdown-ui'
require_relative 'lib/markdown-ui/parser'

class Migrator
  def initialize(options = {})
    @options = options
    @parser = MarkdownUI::Parser.new
    @verbose = options[:verbose] || false
    @dry_run = options[:dry_run] || false
  end
  
  def migrate_all
    puts "=== MarkdownUI Migration ==="
    puts "Dry run mode: #{@dry_run}" if @dry_run
    puts
    
    # Step 1: Backup current tests
    backup_tests if !@dry_run
    
    # Step 2: Test compatibility with existing test cases
    test_compatibility

    # Step 3: Update main entry points
    update_main_entry_points if !@dry_run

    # Step 4: Create test template
    create_test_template if !@dry_run

    puts
    puts "Migration completed successfully!"
    puts
    puts "Next steps:"
    puts "1. Run 'rake test' to test the architecture"
    puts "2. Update your applications to use MarkdownUI::Parser"
    puts "3. Gradually migrate your tests to the new format"
  end
  
  def test_compatibility
    puts "Testing compatibility with sample inputs..."
    
    test_cases = [
      { input: "__Button|Click me|primary__", desc: "Primary button" },
      { input: "__Table|Name,Age|John,25|Jane,30__", desc: "Simple table" },
      { input: "__Menu|Home|About|Contact|secondary__", desc: "Secondary menu" },
      { input: "__Message|Important info|info__", desc: "Info message" },
      { input: "__List|Item 1|Item 2|Item 3|bulleted__", desc: "Bulleted list" }
    ]
    
    test_cases.each do |test|
      puts "  Testing: #{test[:desc]}"
      
      begin
        result = @parser.parse(test[:input])
        if result && !result.empty?
          puts "    ✓ Parsing successful"
          puts "    Result: #{result.gsub(/\n\s*/, ' ').strip}" if @verbose
        else
          puts "    ✗ Parsing failed"
        end
      rescue => e
        puts "    ✗ Parsing error: #{e.message}"
      end
      puts
    end
  end
  
  def backup_tests
    puts "Creating backup of existing tests..."
    
    require 'fileutils'
    backup_dir = "test_backup_#{Time.now.strftime('%Y%m%d_%H%M%S')}"
    FileUtils.mkdir_p(backup_dir)
    
    test_files = Dir['test/*_test.rb']
    test_files.each do |file|
      backup_file = File.join(backup_dir, File.basename(file))
      FileUtils.cp(file, backup_file)
      puts "  Backed up: #{file} -> #{backup_file}"
    end
    
    puts "Tests backed up to: #{backup_dir}"
    puts
  end
  
  def update_main_entry_points
    puts "Updating main entry points..."

    # Update lib/markdown-ui.rb to include parser by default
    main_file = 'lib/markdown-ui.rb'

    if File.exist?(main_file)
      content = File.read(main_file)

      # Add parser require
      new_content = content.dup
      unless content.include?("require_relative 'markdown-ui/parser'")
        new_content += "\n# Main parser\nrequire_relative 'markdown-ui/parser'\n"
      end

      if new_content != content
        File.write(main_file, new_content)
        puts "  Updated: #{main_file}"
      else
        puts "  Already up to date: #{main_file}"
      end
    else
      puts "  Warning: #{main_file} not found"
    end

    puts
  end
  
  def create_test_template
    puts "Creating test template..."

    template_content = <<~RUBY
      # frozen_string_literal: true

      require 'test_helper'
      require_relative '../lib/markdown-ui/parser'

      class ArchitectureTest < Minitest::Test
        def setup
          @parser = MarkdownUI::Parser.new
        end
        
        def test_button_element
          input = "__Button|Click me|primary__"
          result = @parser.parse(input)
          
          assert_includes result, 'ui primary button'
          assert_includes result, 'Click me'
        end
        
        def test_table_element
          input = "__Table|Name,Age|John,25|Jane,30__"
          result = @parser.parse(input)
          
          assert_includes result, '<table class="ui table">'
          assert_includes result, '<th>Name</th>'
          assert_includes result, '<td>John</td>'
        end
        
        def test_message_element
          input = "__Message|Important info|info__"
          result = @parser.parse(input)
          
          assert_includes result, 'ui message'
          assert_includes result, 'Important info'
        end
        
        def test_menu_element
          input = "__Menu|Home|About|Contact|secondary__"
          result = @parser.parse(input)
          
          assert_includes result, 'ui secondary menu'
          assert_includes result, '<div class="item">Home</div>'
        end
        
        def test_list_element
          input = "__List|Item 1|Item 2|Item 3|bulleted__"
          result = @parser.parse(input)
          
          assert_includes result, 'ui bulleted list'
          assert_includes result, '<div class="item">Item 1</div>'
        end
        
        def test_multiple_elements
          input = "__Button|Click me|primary__ and __Message|Hello|info__"
          result = @parser.parse(input)
          
          assert_includes result, 'ui primary button'
          assert_includes result, 'ui message'
        end
        
        def test_registered_elements
          elements = @parser.registered_elements
          
          # Check that all major elements are registered
          expected_elements = %w[
            button table message menu form card modal segment
            input header image label container divider icon content
            flag loader list step breadcrumb grid
          ]
          
          expected_elements.each do |expected_element|
            assert_includes elements, expected_element, "Element '#{expected_element}' should be registered"
          end
        end
        
        def test_backwards_compatibility
          # Test that V2 can parse V1-style inputs
          v1_inputs = [
            "__Button|Save|primary__",
            "__Table|A,B|1,2__",
            "__Message|Test|success__"
          ]
          
          v1_inputs.each do |input|
            result = @parser.parse(input)
            assert result.length > 0, "V2 should parse V1 input: #{input}"
          end
        end
      end
    RUBY
    
    test_file = 'test/architecture_test.rb'
    File.write(test_file, template_content)
    puts "  Created: #{test_file}"
    puts
  end
end

# CLI interface
if __FILE__ == $0
  require 'optparse'
  
  options = {}
  
  OptionParser.new do |opts|
    opts.banner = "Usage: #{$0} [options]"
    
    opts.on("-v", "--verbose", "Run verbosely") do
      options[:verbose] = true
    end
    
    opts.on("-d", "--dry-run", "Show what would be done without making changes") do
      options[:dry_run] = true
    end
    
    opts.on("-h", "--help", "Show this message") do
      puts opts
      exit
    end
  end.parse!
  
  migrator = Migrator.new(options)
  migrator.migrate_all
end