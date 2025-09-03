#!/usr/bin/env ruby

# Fix indentation for all element files
Dir.glob('lib/markdown-ui/elements/*.rb').each do |file|
  puts "Fixing #{file}..."
  content = File.read(file)
  
  # Fix the structure
  fixed_content = content.gsub(/^(\s*)/, '')  # Remove all leading whitespace
  
  lines = fixed_content.split("\n")
  fixed_lines = []
  indent_level = 0
  
  lines.each do |line|
    stripped = line.strip
    
    # Skip empty lines
    if stripped.empty?
      fixed_lines << ''
      next
    end
    
    # Decrease indent for end statements
    if stripped == 'end'
      indent_level -= 1
    elsif stripped == 'private'
      # Private stays at current level
    elsif stripped.start_with?('module ') || stripped.start_with?('class ')
      # Module/class increases indent after
    elsif stripped.start_with?('def ')
      # Method increases indent after
    end
    
    # Add proper indentation
    fixed_lines << ('  ' * indent_level) + stripped
    
    # Increase indent for certain lines
    if stripped.start_with?('module ') || stripped.start_with?('class ') || 
       stripped.start_with?('def ') || stripped == 'private'
      indent_level += 1
    end
  end
  
  File.write(file, fixed_lines.join("\n") + "\n")
end

puts "Indentation fixed!"