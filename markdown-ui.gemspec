# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'markdown-ui/version'

Gem::Specification.new do |spec|
  spec.name          = "markdown-ui"
  spec.version       = MarkdownUI::VERSION
  spec.authors       = ["Joel Bryan Juliano"]
  spec.email         = ["joelbryan.juliano@gmail.com"]

  spec.summary       = %q{Responsive User Interfaces in Markdown}
  spec.description   = %q{Create responsive UI/UX for mobile and web using Markdown Syntax}
  spec.homepage      = "https://github.com/jjuliano/markdown-ui"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "redcarpet", "~> 3.2"
  spec.add_dependency "nokogiri", "~> 1.6"
  spec.add_development_dependency "test-unit", "~> 3.0"
  spec.add_development_dependency "simplecov", "~> 0.10"
end