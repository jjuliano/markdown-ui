# coding: UTF-8
require 'markdown-ui/version'

require 'redcarpet'
require 'nokogiri'
require 'ostruct'

module MarkdownUI
  module Element
    require 'markdown-ui-button'
    require 'markdown-ui-container'
    require 'markdown-ui-content'
    require 'markdown-ui-grid'
  end
end

['markdown-ui/**/*.rb'].each do |dir|
  Dir[File.join(File.dirname(__FILE__), dir)].sort.each { |f| require_relative f }
end

module MarkdownUI
  class Renderer < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants
    include MarkdownUI::Element

    def paragraph(text)
      text
    end

    def emphasis(text)
      MarkdownUI::Content::Icon.new(text).render
    end

    def double_emphasis(text)
      args = text.split('|')
      element = args[0].split(' ')

      content = if args[1].strip =~ /\,/
        args[1].split(',')
      else
        args[1].strip
      end if !args[1].nil?

      klass = if args[0].strip =~ /\./
        k = args[0].split('.')
        k.reverse!
        k.shift
      end

      _id = !args[2].nil? ? args[2].downcase : nil

      data_attributes = !args[3].nil? ? args[3].downcase : nil

      html do
        case element.join(' ')
          when /button/i
            MarkdownUI::Button::Element.new(element, content, klass, _id).render
          when /menu/i
            MarkdownUI::Menu::Element.new(element, content, klass).render
          when /message/i
            MarkdownUI::Message.new(element, content, klass).render
          when /tag/i
            MarkdownUI::Tag.new(element[0].downcase, content, _id, data_attributes).render
          when /header/i
            MarkdownUI::Header.new(content, 0).render
        end
      end
    end

    def block_quote(text)
      element, content = text.split(':')

      html do
        case element
          when /segment/i
            MarkdownUI::Segment.new(element, content).render
          when /grid/i
            MarkdownUI::Grid.new(element, content).render
          when /column/i
            MarkdownUI::Column.new(element, content).render
          when /container/i
            MarkdownUI::Container::Element.new(element, content).render
          when /buttons/i
            MarkdownUI::Button::Group::Buttons::Element.new(element, content).render
          when /button/i
            MarkdownUI::Button::Element.new(element, content).render
          when /menu/i
            MarkdownUI::Menu::Element.new(element, content).render
          when /message/i
            MarkdownUI::Message.new(element, content).render
          when /label/i
            MarkdownUI::Label::Element.new(element, content).render
        end
      end
    end

    def list(content, list_type)
      klass = 'ui'
      html { MarkdownUI::Content::List.new(content, klass, list_type).render }
    end

    def link(link, klass, content)
      _klass = "ui #{klass}"
      html { MarkdownUI::Content::Item.new(content, _klass, link).render }
    end

    def quote(text)
      html { "<p>#{text}</p>" }
    end

    def header(text, level)
      html { MarkdownUI::Header.new(text, level).render }
    end

    def table_cell(content, alignment)
      body, klass = content.split(':')

      "<div class=\"ui #{klass}column\">#{body}</div>"
    end

    protected

    def html
      if block_given?
        HTMLFormatter.new(yield).to_html
      end
    end

  end

  class HTMLFormatter
    def initialize(text)
      @doc = Nokogiri::XML(text, &:noblanks).to_xhtml(indent: 2)
    end

    def to_html
      @doc
    end
  end
end
