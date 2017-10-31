require 'redcarpet'
require 'nokogiri'
require 'loofah'
require 'cgi'
require 'erector'

require_relative 'markdown_ui/tools/html_formatter'
require_relative 'markdown_ui/parser'
require_relative 'markdown_ui/renderers/block_quote'
require_relative 'markdown_ui/renderers/paragraph'
require_relative 'markdown_ui/renderers/quote'

module MarkdownUI
  class Renderer < Redcarpet::Render::HTML
    include MarkdownUI::Renderers::BlockQuote
    include MarkdownUI::Renderers::Paragraph
    include MarkdownUI::Renderers::Quote
  end
end
