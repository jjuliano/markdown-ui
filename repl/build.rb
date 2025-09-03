#!/usr/bin/env ruby

# Pure WebAssembly build script for MarkdownUI REPL
# Uses rbwasm build as described in ruby.wasm documentation

require 'fileutils'
require 'json'

BUILD_DIR = File.join(__dir__, 'build')

puts "🔨 Building MarkdownUI REPL with pure WebAssembly..."
puts "Build Directory: #{BUILD_DIR}"

# Clean build directory
if Dir.exist?(BUILD_DIR)
  puts "🧹 Cleaning existing build directory..."
  FileUtils.rm_rf(BUILD_DIR)
end

# Create build directory structure
FileUtils.mkdir_p(BUILD_DIR)
FileUtils.mkdir_p(File.join(BUILD_DIR, 'css'))
FileUtils.mkdir_p(File.join(BUILD_DIR, 'js'))
FileUtils.mkdir_p(File.join(BUILD_DIR, 'examples'))

# Copy local lib directory for development
puts "📚 Copying local markdown-ui lib for development..."
lib_source = File.join(__dir__, '..', 'lib')
lib_dest = File.join(__dir__, 'lib')

if Dir.exist?(lib_source)
  # Remove existing lib if it exists
  FileUtils.rm_rf(lib_dest) if Dir.exist?(lib_dest)
  
  # Copy the entire lib directory
  FileUtils.cp_r(lib_source, lib_dest)
  puts "✓ Copied #{lib_source} to #{lib_dest}"
  
  # List what was copied
  puts "📁 Local lib contents:"
  Dir.glob("#{lib_dest}/**/*").each do |file|
    next if File.directory?(file)
    puts "  #{file.sub("#{lib_dest}/", '')}"
  end
else
  puts "⚠️  Warning: #{lib_source} not found, will use gem version"
end

# Copy web assets
puts "📋 Copying web assets..."

# Copy HTML
FileUtils.cp('index.html', File.join(BUILD_DIR, 'index.html'))
puts "✓ Copied index.html"

# Copy CSS
FileUtils.cp('css/repl.css', File.join(BUILD_DIR, 'css', 'repl.css'))
puts "✓ Copied css/repl.css"

# Copy JavaScript files
FileUtils.cp('js/ruby-wasm-integration.js', File.join(BUILD_DIR, 'js', 'ruby-wasm-integration.js'))
FileUtils.cp('js/repl-interface.js', File.join(BUILD_DIR, 'js', 'repl-interface.js'))
puts "✓ Copied JavaScript files"

# Copy examples
Dir.glob('examples/*.md').each do |example|
  FileUtils.cp(example, File.join(BUILD_DIR, 'examples', File.basename(example)))
  puts "✓ Copied #{example}"
end

# Copy local lib to build directory for WebAssembly
if Dir.exist?(lib_dest)
  build_lib_dest = File.join(BUILD_DIR, 'lib')
  FileUtils.cp_r(lib_dest, build_lib_dest)
  puts "✓ Copied lib to build directory for WebAssembly"
end

# Build WebAssembly using rbwasm with bundler support (proper way for gems)
puts "🔧 Building WebAssembly with dependencies using rbwasm..."

# Use bundle exec rbwasm build with bundler support as described in the ruby.wasm documentation
wasm_output = File.join(BUILD_DIR, 'markdown-ui.wasm')
build_cmd = "bundle exec rbwasm build -o '#{wasm_output}'"

puts "Running: #{build_cmd}"
puts "This will package Ruby + all gems from Gemfile.lock (including markdown-ui gem)"

if system(build_cmd)
  puts "✅ WebAssembly build successful!"
  puts "✓ Created #{wasm_output}"

  if File.exist?(wasm_output)
    file_size = File.size(wasm_output)
    puts "📊 WebAssembly file size: #{file_size} bytes (#{(file_size / 1024.0 / 1024.0).round(2)} MB)"
    puts "📦 This bundle includes:"
    puts "  - Ruby 3.4 runtime"
    puts "  - Standard library"
    puts "  - Local markdown-ui lib (development version)"
    puts "  - js gem for browser integration"
    puts "  - All other gems from Gemfile.lock"
  end
else
  puts "❌ WebAssembly build failed!"
  puts "Command was: #{build_cmd}"
  puts ""
  puts "Make sure you have:"
  puts "  - Ruby wasm gem installed: gem install ruby_wasm"
  puts "  - Bundler setup completed: bundle install"
  puts "  - Rust toolchain installed: https://rustup.rs/"
  puts "  - All gem dependencies resolved: bundle lock"
  puts ""
  puts "If you're missing the Rust toolchain:"
  puts "  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
  puts "  source ~/.cargo/env"
  puts ""
  exit 1
end

# Create build info
build_info = {
  'build_time' => Time.now.iso8601,
  'version' => '1.0.0',
  'description' => 'MarkdownUI REPL - Pure WebAssembly Implementation',
  'webassembly_included' => true,
  'webassembly_size' => File.size(wasm_output),
  'build_method' => 'rbwasm build'
}

File.write(File.join(BUILD_DIR, 'build-info.json'), JSON.pretty_generate(build_info))
puts "✓ Created build-info.json"

puts ""
puts "🎉 Pure WebAssembly build complete!"
puts "📁 Build output: #{BUILD_DIR}/"
puts "🚀 To serve the application:"
puts "  cd #{BUILD_DIR}"
puts "  python3 -m http.server 8080"
puts "  # Then visit: http://localhost:8080"
puts ""
puts "📦 Build contents:"
Dir.glob("#{BUILD_DIR}/**/*").each do |file|
  next if File.directory?(file)
  puts "  #{file.sub("#{BUILD_DIR}/", '')}"
end

puts ""
puts "✅ SUCCESS: Pure WebAssembly implementation ready!"
puts "🎯 Real Ruby MarkdownUI parser will run in the browser!"
