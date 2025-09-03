module MarkdownUI
  module SemanticModule
    ['../../components/modules/**/*.rb'].each do |dir|
      Dir[File.join(File.dirname(__FILE__), dir)].sort.each { |f| require_relative f }
    end
  end
end