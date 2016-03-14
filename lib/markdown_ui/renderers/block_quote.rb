require 'byebug'
require_relative '../../markdown_ui/elements/base'
require_relative '../../markdown_ui/elements/html'

module MarkdownUI
  module Renderers
    module BlockQuote
      def block_quote(text)
        raw_text = MarkdownUI::Tools::HTMLFormatter.filter_text(text)
        markdown_text = raw_text.match(/^\%(.*)/)
        markdown_contents = raw_text.split("\n")[1..-1]
        markdown_elements = markdown_text[1].split
        @tag = markdown_elements[0]
        @tag_classes = []
        @tag_attributes = []
        @tag_id = ""
        
        @tag_contents = MarkdownUI::Parser.new.render(markdown_contents.join)
        
        markdown_elements.each do |element|
          tag_class = element.match(/\.(.*)/)
          @tag_classes << tag_class[1].strip.gsub('\.', '') if tag_class
          
          tag_attributes = element.match(/\@(.*)/)
          @tag_attributes << tag_attributes[1].strip.gsub('\@', '') if tag_attributes
          
          tag_id = element.match(/\#(.*)/)
          @tag_id = tag_id[1].strip.gsub('\#', '') if tag_id
        end

        @elements = Hash.new(MarkdownUI::Elements::Base).merge(
            html:      MarkdownUI::Elements::HTML
        )
        
        tag_id = @tag_id.strip
        tag_classes = @tag_classes.join(' ')
        tag_attributes = @tag_attributes.join(' ')
        tag_contents = @tag_contents.strip

        @elements[key].new({tag_id: tag_id, tag_classes: tag_classes, tag_attributes: tag_attributes, tag_contents: tag_contents}).render
      end

      protected

      def regexp
        Regexp.new (@tag.split.collect { |u| u.downcase }).join('|'), "i"
      end

      def key
        keys.grep(regexp).first
      end

      def keys
        @elements.keys
      end
    end
  end
end