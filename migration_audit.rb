#!/usr/bin/env ruby

# Audit script to analyze current MarkdownUI architecture
require 'find'
require 'pathname'

puts "=== MarkdownUI Architecture Audit ==="
puts

# 1. Components by category
categories = {}
Find.find('components') do |path|
  next unless File.directory?(path)
  next if path == 'components'
  
  parts = Pathname.new(path).each_filename.to_a
  if parts.length == 2 # category level
    category = parts[1]
    categories[category] ||= []
  elsif parts.length == 3 # component level
    category = parts[1] 
    component = parts[2]
    categories[category] ||= []
    categories[category] << component
  end
end

categories.each do |category, components|
  puts "#{category.upcase}:"
  components.compact.sort.each { |comp| puts "  - #{comp}" }
  puts
end

# 2. Current renderers
puts "CURRENT RENDERERS:"
Dir['lib/markdown-ui/renderers/*.rb'].each do |file|
  puts "  - #{File.basename(file, '.rb')}"
end
puts

# 3. Test files
puts "TEST FILES:"
Dir['test/*_test.rb'].each do |file|
  puts "  - #{File.basename(file, '.rb')}"
end
puts

# 4. Main entry points
puts "MAIN ENTRY POINTS:"
Dir['lib/markdown-ui*.rb'].each do |file|
  puts "  - #{file}"
end
puts

puts "Total components to migrate: #{categories.values.flatten.length}"