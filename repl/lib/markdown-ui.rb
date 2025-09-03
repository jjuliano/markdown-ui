# frozen_string_literal: true

# MarkdownUI - Convert Markdown with Semantic UI components to HTML
# Complete Semantic UI coverage with modern architecture

require_relative 'markdown-ui/version'
require_relative 'markdown-ui/parser'

module MarkdownUI
  # Create a new parser instance
  def self.new(options = {})
    Parser.new(options)
  end
  
  # Parse markdown content directly
  def self.parse(markdown, options = {})
    new(options).parse(markdown)
  end
  
  # Version information
  def self.version
    VERSION
  end
end