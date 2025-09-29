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

    # Collection Renderers
    include MarkdownUI::Renderers::Breadcrumb
    include MarkdownUI::Renderers::Form
    include MarkdownUI::Renderers::Grid
    include MarkdownUI::Renderers::Menu
    include MarkdownUI::Renderers::Message
    include MarkdownUI::Renderers::Table

    # Module Renderers
    include MarkdownUI::Renderers::Accordion
    include MarkdownUI::Renderers::Calendar
    include MarkdownUI::Renderers::Checkbox
    include MarkdownUI::Renderers::Dimmer
    include MarkdownUI::Renderers::Dropdown
    include MarkdownUI::Renderers::Embed
    include MarkdownUI::Renderers::Flyout
    include MarkdownUI::Renderers::Modal
    include MarkdownUI::Renderers::Nag
    include MarkdownUI::Renderers::Popup
    include MarkdownUI::Renderers::Progress
    include MarkdownUI::Renderers::Rating
    include MarkdownUI::Renderers::Search
    include MarkdownUI::Renderers::Shape
    include MarkdownUI::Renderers::Sidebar
    include MarkdownUI::Renderers::Slider
    include MarkdownUI::Renderers::Sticky
    include MarkdownUI::Renderers::Tab
    include MarkdownUI::Renderers::Toast
    include MarkdownUI::Renderers::Transition

    # Element Renderers
    include MarkdownUI::Renderers::Button
    include MarkdownUI::Renderers::Container
    include MarkdownUI::Renderers::Divider
    include MarkdownUI::Renderers::Emoji
    include MarkdownUI::Renderers::Field
    include MarkdownUI::Renderers::Flag
    include MarkdownUI::Renderers::Icon
    include MarkdownUI::Renderers::Image
    include MarkdownUI::Renderers::Input
    include MarkdownUI::Renderers::Label
    include MarkdownUI::Renderers::Loader
    include MarkdownUI::Renderers::Placeholder
    include MarkdownUI::Renderers::Rail
    include MarkdownUI::Renderers::Reveal
    include MarkdownUI::Renderers::Segment
    include MarkdownUI::Renderers::Step
    include MarkdownUI::Renderers::Text

    # View Renderers
    include MarkdownUI::Renderers::Advertisement
    include MarkdownUI::Renderers::Card
    include MarkdownUI::Renderers::Comment
    include MarkdownUI::Renderers::Feed
    include MarkdownUI::Renderers::Item
    include MarkdownUI::Renderers::Statistic

    # Behavior Renderers
    include MarkdownUI::Renderers::Api
    include MarkdownUI::Renderers::State
    include MarkdownUI::Renderers::Visibility

    protected

    def html
      if block_given?
        HTMLFormatter.new(yield).to_html
      end
    end
  end
end
