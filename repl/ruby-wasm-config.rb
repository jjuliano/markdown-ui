#!/usr/bin/env ruby

# Ruby WebAssembly configuration for MarkdownUI REPL
require 'bundler'

Bundler.require

# Build configuration for ruby.wasm
RUBY_WASM_CONFIG = {
  # Include the MarkdownUI gem and its dependencies
  gems: [
    'markdown-ui',
    'redcarpet',
    'cgi',
    'json'
  ],

  # Files to include in the WebAssembly bundle
  include_files: [
    'lib/markdown-ui.rb',
    'lib/markdown-ui/**/*.rb'
  ],

  # Standard library modules needed
  stdlib: [
    'cgi',
    'json',
    'digest/md5',
    'strscan'
  ],

  # Export specific classes and methods
  exports: [
    'MarkdownUI::Parser',
    'MarkdownUI::Tokenizer',
    'MarkdownUI::ElementRegistry'
  ]
}

# Build the WebAssembly module
def build_wasm
  puts "Building MarkdownUI for WebAssembly..."

  # This would typically use the ruby-wasm gem to compile
  # For now, we'll create a placeholder structure
  wasm_dir = File.join(__dir__, 'dist')
  FileUtils.mkdir_p(wasm_dir)

  # Copy necessary Ruby files
  ruby_files = Dir.glob(File.join(__dir__, '..', 'lib', '**', '*.rb'))
  ruby_files.each do |file|
    relative_path = file.sub(File.join(__dir__, '..', 'lib'), '')
    dest = File.join(wasm_dir, 'lib', relative_path)
    FileUtils.mkdir_p(File.dirname(dest))
    FileUtils.cp(file, dest)
  end

  puts "WebAssembly build complete!"
end

# Run build if called directly
build_wasm if __FILE__ == $0

