# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "markdown-ui/version"

Gem::Specification.new do |spec|
  spec.name          = "markdown-ui"
  spec.version       = MarkdownUI::VERSION
  spec.authors       = ["Joel Bryan Juliano"]
  spec.email         = ["joelbryan.juliano@gmail.com"]

  spec.summary       = %q{Complete Semantic UI components in Markdown}
  spec.description   = %q{Modern architecture supporting all 45+ Semantic UI elements with simple Markdown syntax}
  spec.homepage      = "https://github.com/jjuliano/markdown-ui"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting "allowed_push_host", or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = Dir.glob("{lib,exe}/**/*") + %w[README.md LICENSE.txt CHANGELOG.md]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Runtime dependencies
  spec.add_dependency "redcarpet", "~> 3.6"
  spec.add_dependency "htmlbeautifier", "~> 1.4"
  spec.add_dependency "webrick", "~> 1.8"
  
  # Development dependencies
  spec.add_development_dependency "bundler", ">= 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
