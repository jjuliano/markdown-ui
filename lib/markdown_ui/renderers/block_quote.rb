require 'byebug'
require_relative '../../markdown_ui/elements/tag'
require_relative '../../markdown_ui/elements/raw_text'

module MarkdownUI
  module Renderers
    module BlockQuote
      def block_quote(text)
        raw_text = MarkdownUI::Elements::RawText.new(text: text).to_s
        raw_markdown_text = raw_text.match(/^\%(.*)/)
        markdown_text = raw_markdown_text.nil? ? text : raw_markdown_text[1]
        markdown_inline_contents = raw_text.match(/\ \'(.*)\'/)
        markdown_block_contents = raw_text.match(/\n(.*)/)
        markdown_elements = markdown_text.split unless markdown_text.nil?

        @tag = markdown_elements[0]
        @tag_classes = []
        @tag_id = ''
        @tag_contents = if !markdown_block_contents.nil?
                          markdown_block_contents[1]
                        elsif !markdown_inline_contents.nil?
                          markdown_inline_contents[1]
                        else
                          ''
                        end
        @tag_attributes = {}

        unless markdown_elements.nil?
          markdown_elements.each do |element|
            tag_class = element.match(/\.(.*)/)
            @tag_classes << tag_class[1].strip.gsub('\.', '') if tag_class

            tag_attributes = element.match(/\@(.*)=(.*)/) || element.match(/\@(.*)/)
            if tag_attributes.is_a?(MatchData)
              if tag_attributes.size == 2
                k = tag_attributes[1].strip.gsub('\@', '').to_sym
                v = true
              elsif tag_attributes.size == 3
                k = tag_attributes[1].strip.gsub('\@', '').to_sym
                v = !tag_attributes[2].empty? ? tag_attributes[2].delete('"').strip : ''
              end
              @tag_attributes[k] = v
            end

            tag_id = element.match(/\#(.*)/)
            @tag_id = tag_id[1].strip.gsub('\#', '') if tag_id
          end
        end

        params = {}
        params[:tag] = @tag
        params[:tag_id] = MarkdownUI::Elements::TagID.new(tag_id: @tag_id).to_s unless @tag_id.empty?
        params[:tag_classes] = MarkdownUI::Elements::TagClasses.new(tag_classes: @tag_classes).to_s unless @tag_classes.empty?
        # @tag_classes.join(' ') unless @tag_classes.empty?
        params[:tag_attributes] = @tag_attributes unless @tag_attributes.nil?
        params[:tag_contents] = @tag_contents unless @tag_contents.nil?

        MarkdownUI::Elements::Tag.new(params).render
      end
    end
  end
end
