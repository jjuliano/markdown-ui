require "markdown-ui/version"

# coding: UTF-8
require 'redcarpet'
require 'nokogiri'
require 'ostruct'

['markdown-ui/**/*.rb'].each do |dir|
  Dir[File.join(File.dirname(__FILE__), dir)].sort.each { |f| require_relative f }
end

module MarkdownUI
  class Renderer < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants

    def paragraph(text)
      text
    end

    def emphasis(text)
      MarkdownUI::Content::Icon.new(text).render
    end

    def double_emphasis(text)
      args = text.split("|")
      element = args[0].split(" ")

      content = if args[1].strip =~ /\,/
        args[1].split(",")
      else
        args[1].strip
      end

      klass = !args[2].nil? ? args[2].downcase : nil
      data_attributes = !args[3].nil? ? args[3].downcase : nil

      HTMLFormatter.new(
        case element.join(" ")
          when /button/i
            MarkdownUI::Button::Element.new(element, content, klass).render
          when /message/i
            MarkdownUI::Message.new(element, content, klass).render
          when /tag/i
            MarkdownUI::Tag.new(element[0].downcase, content, klass, data_attributes).render
        end
      ).to_html
    end

    def block_quote(text)
      element, content = text.split(':')

      HTMLFormatter.new(
        case element
          when /segment/i
            MarkdownUI::Segment.new(element, content).render
          when /container/i
            MarkdownUI::Container::Element.new(element, content).render
          when /buttons/i
            MarkdownUI::Button::Group::Element.new(element, content).render
          when /button/i
            MarkdownUI::Button::Element.new(element, content).render
        end
      ).to_html
    end

    def quote(text)
      HTMLFormatter.new(
        "<p>#{text}</p>"
      ).to_html
    end

    def header(text, level)
      HTMLFormatter.new(
        MarkdownUI::Header.new(text, level).render
      ).to_html
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
