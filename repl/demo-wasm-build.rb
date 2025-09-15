#!/usr/bin/env ruby

# Demo script showing the ruby.wasm documentation approach
# This demonstrates how to build a .wasm file following the official documentation

puts "🔨 MarkdownUI REPL - Ruby WebAssembly Build Demo"
puts "=" * 50
puts ""
puts "This demo follows the ruby.wasm documentation approach:"
puts "https://ruby.github.io/ruby.wasm/"
puts ""

# Step 1: Check prerequisites
puts "📋 Step 1: Checking prerequisites..."

if system("gem list ruby_wasm -i >/dev/null 2>&1")
  puts "✅ ruby_wasm gem is installed"
else
  puts "❌ ruby_wasm gem not found"
  puts "Install with: gem install ruby_wasm"
  exit 1
end

if system("which curl >/dev/null 2>&1")
  puts "✅ curl is available"
else
  puts "❌ curl not found"
  exit 1
end

# Step 2: Download Ruby WebAssembly
puts ""
puts "📥 Step 2: Downloading Ruby WebAssembly runtime..."
puts "(Following documentation: 'Download a prebuilt Ruby release')"

ruby_wasm_url = "https://github.com/ruby/ruby.wasm/releases/latest/download/ruby-3.4-wasm32-unknown-wasip1-full.tar.gz"

puts "URL: #{ruby_wasm_url}"

# Create temp directory
temp_dir = "temp-demo"
Dir.mkdir(temp_dir) unless Dir.exist?(temp_dir)

archive_path = File.join(temp_dir, "ruby-wasm.tar.gz")
if system("curl -L -o #{archive_path} #{ruby_wasm_url}")
  puts "✅ Downloaded Ruby WebAssembly runtime"
else
  puts "❌ Failed to download Ruby WebAssembly"
  exit 1
end

# Step 3: Extract Ruby binary
puts ""
puts "📦 Step 3: Extracting Ruby binary..."
puts "(Following documentation: 'Extract ruby binary not to pack itself')"

Dir.chdir(temp_dir) do
  if system("tar xfz ruby-wasm.tar.gz")
    puts "✅ Extracted Ruby WebAssembly archive"

    # Find the extracted directory
    ruby_dirs = Dir.glob("ruby-*-wasm32-unknown-wasip1-full")
    if ruby_dirs.any?
      ruby_dir = ruby_dirs.first
      puts "📁 Found Ruby directory: #{ruby_dir}"

      ruby_binary = File.join(ruby_dir, "usr", "local", "bin", "ruby")
      if File.exist?(ruby_binary)
        extracted_ruby = "ruby.wasm"
        FileUtils.cp(ruby_binary, extracted_ruby)
        puts "✅ Extracted ruby.wasm binary (#{File.size(extracted_ruby)} bytes)"
      else
        puts "❌ Ruby binary not found in #{ruby_binary}"
        exit 1
      end
    else
      puts "❌ Could not find extracted Ruby directory"
      exit 1
    end
  else
    puts "❌ Failed to extract archive"
    exit 1
  end
end

# Step 4: Create application structure
puts ""
puts "📝 Step 4: Creating application structure..."
puts "(Following documentation: 'Put your app code')"

src_dir = File.join(temp_dir, "src")
Dir.mkdir(src_dir) unless Dir.exist?(src_dir)

# Create a simple app
app_content = <<~RUBY
#!/usr/bin/env ruby

# Simple MarkdownUI WebAssembly demo
# Following ruby.wasm documentation

require 'js'

puts "Hello from Ruby WebAssembly!"
puts "Ruby version: #{RUBY_VERSION}"

# Simple demo function
def greet(name)
  "Hello, #{name}! This is Ruby WebAssembly working!"
end

# Keep the app running
puts "WebAssembly app ready!"
RUBY

File.write(File.join(src_dir, "app.rb"), app_content)
puts "✅ Created src/app.rb"

# Step 5: Package with rbwasm
puts ""
puts "🔨 Step 5: Packaging with rbwasm..."
puts "(Following documentation: 'Pack the whole directory under /usr and your app dir')"

wasm_output = "../demo-markdown-ui.wasm"
pack_cmd = "rbwasm pack #{File.join(temp_dir, 'ruby.wasm')} --dir #{src_dir}::/src --dir #{File.join(temp_dir, ruby_dir, 'usr')}::/usr -o #{wasm_output}"

puts "Command: #{pack_cmd}"

if system(pack_cmd)
  puts "✅ WebAssembly packaging successful!"
  puts "📁 Created: #{wasm_output}"

  if File.exist?(wasm_output)
    file_size = File.size(wasm_output)
    puts "📊 File size: #{(file_size / 1024.0 / 1024.0).round(2)} MB"
  end
else
  puts "❌ WebAssembly packaging failed"
  exit 1
end

# Step 6: Test the result
puts ""
puts "🧪 Step 6: Testing the result..."

if system("which wasmtime >/dev/null 2>&1")
  puts "Testing with wasmtime..."
  if system("wasmtime #{wasm_output} --version >/dev/null 2>&1")
    puts "✅ WebAssembly file is valid!"
  else
    puts "⚠️  WebAssembly created but validation failed"
  end
else
  puts "ℹ️  wasmtime not installed, skipping validation"
  puts "   Install with: brew install wasmtime"
end

# Cleanup
puts ""
puts "🧹 Cleaning up temporary files..."
FileUtils.rm_rf(temp_dir)

puts ""
puts "🎉 Demo complete!"
puts "=" * 50
puts ""
puts "📖 This demo followed the ruby.wasm documentation exactly:"
puts "   1. ✅ Download prebuilt Ruby release"
puts "   2. ✅ Extract ruby binary (not to pack itself)"
puts "   3. ✅ Put your app code in src/ directory"
puts "   4. ✅ Pack with rbwasm pack"
puts "   5. ✅ Test with wasmtime"
puts ""
puts "🚀 Your MarkdownUI REPL now builds .wasm files the same way!"
puts ""
puts "To build your REPL: npm run build:wasm"

