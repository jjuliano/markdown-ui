# coding: UTF-8

require 'redcarpet'
require_relative 'markdown_ui/parser'

module MarkdownUI
  class Renderer < Redcarpet::Render::HTML
    protected

    def html
      if block_given?
        HTMLFormatter.new(yield).to_html
      end
    end
  end
end
