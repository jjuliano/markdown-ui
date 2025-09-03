# Test the key selection logic manually
params = ["Pointing", "Menu"]
regexp = Regexp.new(params.collect { |u| u.downcase }.join('|'), "i")
keys = [:button, :segment, :grid, :row, :column, :container, :buttons, :label, :span, :content, :divider, :field, :fields, :form, :item, :tag, :menu, :message, :input, :header, :card, :comment, :modal, :accordion, :pointing, :secondary, :pagination, :tabular, :text, :vertical]

matching_keys = keys.grep(regexp)
puts "Params: #{params.inspect}"
puts "Regexp: #{regexp.inspect}"  
puts "Matching keys: #{matching_keys.inspect}"

if matching_keys.length > 1
  # Prefer more specific matches (longer param names)
  param_lengths = params.collect { |p| [p.downcase, p.length] }.to_h
  selected = matching_keys.sort_by { |key| -param_lengths[key.to_s] }.first
  puts "Selected: #{selected}"
else
  puts "Selected: #{matching_keys.first}"
end
