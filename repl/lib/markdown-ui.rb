# coding: UTF-8

require 'redcarpet'
require 'htmlbeautifier'
require 'ostruct'

require_relative 'markdown-ui/shared'

['markdown-ui/**/*.rb'].each do |dir|
  Dir[File.join(File.dirname(__FILE__), dir)].sort.each { |f| require_relative f }
end

module MarkdownUI
  class Renderer < Redcarpet::Render::HTML
    # Basic Renderers
    include MarkdownUI::Renderers::Header
    include MarkdownUI::Renderers::Quote
    include MarkdownUI::Renderers::Link
    include MarkdownUI::Renderers::List
    include MarkdownUI::Renderers::BlockQuote
    include MarkdownUI::Renderers::DoubleEmphasis
    include MarkdownUI::Renderers::Emphasis
    include MarkdownUI::Renderers::Paragraph
    include MarkdownUI::Renderers::HorizontalRule

    # Module Renderers
    include MarkdownUI::Renderers::Accordion
    include MarkdownUI::Renderers::Checkbox
    include MarkdownUI::Renderers::Dimmer
    include MarkdownUI::Renderers::Dropdown
    include MarkdownUI::Renderers::Embed
    include MarkdownUI::Renderers::Modal
    include MarkdownUI::Renderers::Popup
    include MarkdownUI::Renderers::Progress
    include MarkdownUI::Renderers::Rating
    include MarkdownUI::Renderers::Search
    include MarkdownUI::Renderers::Shape
    include MarkdownUI::Renderers::Sidebar
    include MarkdownUI::Renderers::Sticky
    include MarkdownUI::Renderers::Tab
    include MarkdownUI::Renderers::Transition

    # Element Renderers
    include MarkdownUI::Renderers::Loader
    include MarkdownUI::Renderers::Placeholder
    include MarkdownUI::Renderers::Rail
    include MarkdownUI::Renderers::Reveal
    include MarkdownUI::Renderers::Step

    # View Renderers
    include MarkdownUI::Renderers::Advertisement
    include MarkdownUI::Renderers::Card
    include MarkdownUI::Renderers::Comment
    include MarkdownUI::Renderers::Feed
    include MarkdownUI::Renderers::Item
    include MarkdownUI::Renderers::Statistic

    protected

    def html
      if block_given?
        HTMLFormatter.new(yield).to_html
      end
    end
  end
end
