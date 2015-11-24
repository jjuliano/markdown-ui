# coding: UTF-8

require 'redcarpet'
require 'nokogiri'
require 'ostruct'

['markdown-ui/**/*.rb'].each do |dir|
  Dir[File.join(File.dirname(__FILE__), dir)].sort.each { |f| require_relative f }
end

module MarkdownUI
  class Renderer < Redcarpet::Render::HTML
    include MarkdownUI::Renderers::Header
    include MarkdownUI::Renderers::Quote
    include MarkdownUI::Renderers::Link
    include MarkdownUI::Renderers::List
    include MarkdownUI::Renderers::BlockQuote
    include MarkdownUI::Renderers::DoubleEmphasis
    include MarkdownUI::Renderers::Emphasis
    include MarkdownUI::Renderers::Paragraph
    include MarkdownUI::Renderers::HorizontalRule

    protected

    def html
      if block_given?
        HTMLFormatter.new(yield).to_html
      end
    end
  end
end