# coding: UTF-8

require 'redcarpet'
require 'nokogiri'
require 'loofah'
require 'cgi'
require 'fortitude'

require_relative 'markdown_ui/tools/html_formatter'
require_relative 'markdown_ui/parser'
require_relative 'markdown_ui/renderers/block_quote'
# require_relative 'markdown_ui/renderers/paragraph'
require_relative 'markdown_ui/renderers/quote'

module MarkdownUI
  class Renderer < Redcarpet::Render::HTML
    include MarkdownUI::Renderers::BlockQuote
    # include MarkdownUI::Renderers::Paragraph
    include MarkdownUI::Renderers::Quote

    protected

    def html(text)
      MarkdownUI::Tools::HTMLFormatter.new(text).to_html
    end
  end
end
