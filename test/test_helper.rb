# coding: UTF-8
Encoding.default_internal = 'UTF-8' if defined? Encoding

begin
  if ENV['COVERAGE']
    require "codeclimate-test-reporter"
    require 'simplecov'
    SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[SimpleCov::Formatter::HTMLFormatter, CodeClimate::TestReporter::Formatter]
    SimpleCov.start CodeClimate::TestReporter.configuration.profile
  end
rescue LoadError
end

require 'test/unit'

require 'redcarpet'
require 'redcarpet/render_strip'
require 'redcarpet/render_man'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'markdown-ui'

class Redcarpet::TestCase < Test::Unit::TestCase
  def assert_renders(html, markdown)
    assert_equal html, render(markdown)
  end

  def render(markdown, options = {})
    options = options.fetch(:with, {})

    if options.kind_of?(Array)
      options = Hash[options.map { |o| [o, true] }]
    end

    render = renderer.new(options)
    parser = Redcarpet::Markdown.new(render, options)

    parser.render(markdown)
  end

  private

  def renderer
    @renderer ||= Redcarpet::Render::HTML
  end
end
