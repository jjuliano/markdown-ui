['label/**/*.rb'].each do |dir|
  Dir[File.join(File.dirname(__FILE__), dir)].sort.each { |f| require_relative f }
end
