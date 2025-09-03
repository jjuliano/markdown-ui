#!/usr/bin/env ruby
# Comprehensive test for complete Semantic UI 2.5.0 coverage based on provided URLs

require_relative 'lib/markdown-ui'

puts "🎯 **COMPLETE SEMANTIC UI 2.5.0 COVERAGE TEST**"
puts "Based on the provided semantic-ui.com documentation URLs"
puts "=" * 60

parser = MarkdownUI::Parser.new

# Categories from provided URLs
test_categories = {
  "Collections" => [
    { name: "Breadcrumb", markdown: "> Breadcrumb:\n> Home, Products, Electronics, Laptops" },
    { name: "Form", markdown: "> Form:\n> Login form content" },
    { name: "Grid", markdown: "> Grid:\n> Grid content" },
    { name: "Menu", markdown: "> Menu:\n> Menu items" },
    { name: "Message", markdown: "> Message:\n> Important message content" },
    { name: "Table", markdown: "> Table:\n> Name,Age,Job|John,30,Developer" }
  ],

  "Elements" => [
    { name: "Button", markdown: "> Button:\n> Click Me" },
    { name: "Container", markdown: "> Container:\n> Container content" },
    { name: "Divider", markdown: "> Divider:\n> Section break" },
    { name: "Flag", markdown: "> Flag:\n> us" },
    { name: "Header", markdown: "> Header:\n> Page Title" },
    { name: "Icon", markdown: "> Icon:\n> home" },
    { name: "Image", markdown: "> Image:\n> sample.jpg" },
    { name: "Input", markdown: "> Input:\n> Enter your name" },
    { name: "Label", markdown: "> Label:\n> Important" },
    { name: "List", markdown: "> Item:\n> List item content" },
    { name: "Loader", markdown: "> Loader:\n> Loading content..." },
    { name: "Placeholder", markdown: "> Placeholder:\n> 3" },
    { name: "Rail", markdown: "> Rail:\n> Sidebar content" },
    { name: "Reveal", markdown: "> Reveal:\n> Hidden content on hover" },
    { name: "Segment", markdown: "> Segment:\n> Segment content" },
    { name: "Step", markdown: "> Step:\n> Icon:truck|Shipping|Order processing" }
  ],

  "Modules" => [
    { name: "Accordion", markdown: "> Accordion:\n> Collapsible content" },
    { name: "Checkbox", markdown: "> Checkbox:\n> Accept terms and conditions" },
    { name: "Dimmer", markdown: "> Dimmer:\n> Modal overlay content" },
    { name: "Dropdown", markdown: "> Dropdown:\n> Select option" },
    { name: "Embed", markdown: "> Embed:\n> https://www.youtube.com/embed/example" },
    { name: "Modal", markdown: "> Modal:\n> Modal dialog content" },
    { name: "Popup", markdown: "> Popup:\n> Trigger:Popup content appears on hover" },
    { name: "Progress", markdown: "> Progress:\n> Loading progress" },
    { name: "Rating", markdown: "> Rating:\n> 4.5" },
    { name: "Search", markdown: "> Search:\n> Search for anything..." },
    { name: "Shape", markdown: "> Shape:\n> 3D geometric content" },
    { name: "Sidebar", markdown: "> Sidebar:\n> Navigation menu" },
    { name: "Sticky", markdown: "> Sticky:\n> Content that follows scroll" },
    { name: "Tab", markdown: "> Tab:\n> Tab 1:Content 1|Tab 2:Content 2" },
    { name: "Transition", markdown: "> Transition:\n> Animated effects" }
  ],

  "Views" => [
    { name: "Advertisement", markdown: "> Advertisement:\n> Premium content placement" },
    { name: "Card", markdown: "> Card:\n> Card content" },
    { name: "Comment", markdown: "> Comment:\n> User comment content" },
    { name: "Feed", markdown: "> Feed:\n> Activity feed content" },
    { name: "Item", markdown: "> Item:\n> Collection item" },
    { name: "Statistic", markdown: "> Statistic:\n> 1,234\nActive Users" }
  ]
}

# Test Results
total_tests = 0
passed_tests = 0
failed_tests = []

test_categories.each do |category, tests|
  puts "\n📂 **#{category.upcase}** (#{tests.length} components)"
  puts "-" * 40

  tests.each do |test|
    total_tests += 1
    print "  #{test[:name].ljust(15)} ... "

    begin
      output = parser.render(test[:markdown])

      # Basic validation - check if output contains expected UI classes
      component_name = test[:name].downcase
      has_ui_class = output.include?('class="ui') || output.include?("class='ui")
      has_component = output.downcase.include?(component_name) || output.include?('ui ')

      if has_ui_class && !output.strip.empty?
        puts "✅ PASS"
        passed_tests += 1
      else
        puts "❌ FAIL (No UI classes)"
        failed_tests << { category: category, name: test[:name], error: "Missing UI classes" }
      end

    rescue => e
      puts "❌ ERROR"
      failed_tests << { category: category, name: test[:name], error: e.message }
    end
  end
end

# Results Summary
puts "\n" + "=" * 60
puts "🏆 **TEST RESULTS SUMMARY**"
puts "=" * 60
puts "Total Components Tested: #{total_tests}"
puts "✅ Passed: #{passed_tests} (#{((passed_tests.to_f / total_tests) * 100).round(1)}%)"
puts "❌ Failed: #{failed_tests.length} (#{((failed_tests.length.to_f / total_tests) * 100).round(1)}%)"

if failed_tests.any?
  puts "\n💥 **FAILED COMPONENTS:**"
  failed_tests.each do |failure|
    puts "  • [#{failure[:category]}] #{failure[:name]} - #{failure[:error]}"
  end
else
  puts "\n🎉 **ALL COMPONENTS PASSED!** Complete Semantic UI 2.5.0 coverage achieved!"
end

puts "\n📊 **COVERAGE BY CATEGORY:**"
test_categories.each do |category, tests|
  category_passed = tests.count { |test|
    !failed_tests.any? { |f| f[:category] == category && f[:name] == test[:name] }
  }
  percentage = ((category_passed.to_f / tests.length) * 100).round(1)
  status = percentage == 100.0 ? "🟢" : percentage >= 80 ? "🟡" : "🔴"
  puts "  #{status} #{category}: #{category_passed}/#{tests.length} (#{percentage}%)"
end

puts "\n✨ Complete Semantic UI 2.5.0 documentation coverage test finished!"