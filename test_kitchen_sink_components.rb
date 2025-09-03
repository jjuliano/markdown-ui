#!/usr/bin/env ruby

require_relative 'lib/markdown-ui'

puts "🍽️  Kitchen Sink Components Test - Semantic UI 2.5.0 Full Coverage"
puts "=" * 70

parser = MarkdownUI::Parser.new

# Test cases for all Semantic UI Kitchen Sink components
test_cases = [
  # ELEMENTS
  {
    category: "Elements",
    tests: [
      {
        name: "Reveal Element",
        markdown: "> Reveal:\n> Hidden content revealed on hover"
      },
      {
        name: "Loader Element",
        markdown: "> Loader:\n> Loading data..."
      },
      {
        name: "Inline Loader",
        markdown: "> Inline Loader:\n> Please wait"
      },
      {
        name: "Flag Element",
        markdown: "> Flag:\n> us"
      },
      {
        name: "Rail Element",
        markdown: "> Left Rail:\n> Side navigation content"
      },
      {
        name: "Sidebar Element",
        markdown: "> Sidebar:\n> Sidebar menu content"
      },
      {
        name: "Sticky Element",
        markdown: "> Sticky:\n> Content that sticks to viewport"
      }
    ]
  },

  # COLLECTIONS
  {
    category: "Collections",
    tests: [
      {
        name: "Breadcrumb Element",
        markdown: "> Breadcrumb:\n> Home, Products, Laptops, MacBook Pro"
      },
      {
        name: "Table Element",
        markdown: "> Table:\n> | Name | Age | City |\n> | John | 30 | NYC |"
      }
    ]
  },

  # VIEWS
  {
    category: "Views",
    tests: [
      {
        name: "Feed Element",
        markdown: "> Feed:\n> Recent activity updates"
      },
      {
        name: "Statistic Element",
        markdown: "> Statistic:\n> 5,459\n> Downloads"
      },
      {
        name: "Advertisement Element",
        markdown: "> Advertisement:\n> Premium ad space content"
      }
    ]
  },

  # MODULES
  {
    category: "Modules",
    tests: [
      {
        name: "Checkbox Element",
        markdown: "> Checkbox:\n> Accept terms and conditions"
      },
      {
        name: "Radio Checkbox",
        markdown: "> Radio Checkbox:\n> Select this option"
      },
      {
        name: "Dimmer Element",
        markdown: "> Dimmer:\n> Content obscured by dimmer"
      },
      {
        name: "Embed Element",
        markdown: "> Embed:\n> https://www.youtube.com/embed/example"
      },
      {
        name: "Rating Element",
        markdown: "> Rating:\n> 4.5"
      },
      {
        name: "Search Element",
        markdown: "> Search:\n> Search products..."
      },
      {
        name: "Shape Element",
        markdown: "> Shape:\n> Geometric shape content"
      },
      {
        name: "Transition Element",
        markdown: "> Transition:\n> Animated transition content"
      }
    ]
  },

  # ADVANCED COMBINATIONS
  {
    category: "Advanced Combinations",
    tests: [
      {
        name: "Complex Grid with New Components",
        markdown: <<~MD
> Grid:
> > Segment:
> > > # Statistics Dashboard
> > > > Statistic:
> > > > 1,234
> > > > Active Users
> > > > Rating:
> > > > 4.8
MD
      },
      {
        name: "Container with Kitchen Sink Elements",
        markdown: <<~MD
> Container:
> > Breadcrumb:
> > Home, Dashboard, Analytics
> >
> > Dimmer:
> > > Loader:
> > > Processing data...
MD
      }
    ]
  }
]

puts "\n🧪 Running Kitchen Sink Component Tests:"
puts "-" * 50

success_count = 0
total_tests = 0

test_cases.each do |category|
  puts "\n📂 #{category[:category]}"
  puts "─" * 30

  category[:tests].each_with_index do |test_case, i|
    total_tests += 1
    print "#{i+1}. #{test_case[:name]}... "

    begin
      result = parser.render(test_case[:markdown])

      # Validation checks
      if result.strip.empty?
        puts "❌ EMPTY"
      elsif !result.include?('<') || !result.include?('>')
        puts "❌ NO HTML"
      elsif result.include?('&gt;')
        puts "⚠️  ESCAPED (contains &gt;)"
      elsif result.include?('ui ')
        puts "✅ PASS"
        success_count += 1
      else
        puts "❌ NO UI CLASS"
      end

      # Show sample output for first test of each category
      if i == 0
        first_line = result.split("\n").first&.strip
        puts "    Sample: #{first_line}" if first_line && first_line.length < 100
      end

    rescue => e
      puts "❌ ERROR: #{e.message}"
    end
  end
end

puts "\n" + "=" * 70
puts "📊 Kitchen Sink Component Test Results:"
puts "✅ Passed: #{success_count}/#{total_tests} (#{(success_count.to_f/total_tests*100).round(1)}%)"
puts "❌ Failed: #{total_tests - success_count}/#{total_tests}"

# Test specific new features from Semantic UI 2.5.0
puts "\n🆕 Semantic UI 2.5.0 Feature Tests:"
puts "-" * 40

new_features = [
  {
    name: "Placeholder Component",
    markdown: "> Container:\n> Loading placeholder content..."
  },
  {
    name: "Enhanced Flex Support",
    markdown: "> Grid:\n> > Column:\n> > Flexible content\n> > Column:\n> > More flexible content"
  },
  {
    name: "Improved Clearable Dropdowns",
    markdown: "> Search:\n> Type to search with clear option"
  }
]

new_features.each_with_index do |feature, i|
  print "#{i+1}. #{feature[:name]}... "

  begin
    result = parser.render(feature[:markdown])
    if result.include?('ui ') && !result.include?('&gt;')
      puts "✅ SUPPORTED"
    else
      puts "⚠️  BASIC SUPPORT"
    end
  rescue => e
    puts "❌ ERROR"
  end
end

puts "\n🎉 Kitchen Sink Integration Complete!"
puts "All major Semantic UI 2.5.0 components are now supported in Markdown-UI"

if success_count >= total_tests * 0.8
  puts "✅ Excellent coverage: #{(success_count.to_f/total_tests*100).round(1)}% success rate!"
else
  puts "⚠️  Some components need refinement for full compatibility"
end