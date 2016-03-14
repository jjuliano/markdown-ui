require 'byebug'
require_relative '../../markdown_ui/elements/tag'

module MarkdownUI
  module Renderers
    module BlockQuote
      def block_quote(text)
        raw_text = MarkdownUI::Tools::HTMLFormatter.filter_text(text)
        markdown_text = raw_text.match(/^\%(.*)/)
        markdown_contents = raw_text.split("\n")[1..-1]
        markdown_elements = markdown_text[1].split unless markdown_text.nil?

        @tag = markdown_elements[0] unless markdown_text.nil?
        @tag_classes = []
        @tag_id = ""
        @tag_contents = markdown_contents.join("\n") unless markdown_contents.empty?
        @tag_attributes = {}

        unless markdown_elements.nil?
          markdown_elements.each do |element|
            tag_class = element.match(/\.(.*)/)
            @tag_classes << tag_class[1].strip.gsub('\.', '') if tag_class

            tag_attributes = element.match(/\@(.*)=(.*)/) || element.match(/\@(.*)/)
            if tag_attributes.is_a?(MatchData)
              if tag_attributes.size == 2
                k, v = tag_attributes[1].strip.gsub('\@', '').to_sym, true
              elsif tag_attributes.size == 3
                k, v = tag_attributes[1].strip.gsub('\@', '').to_sym, !tag_attributes[2].empty? ? tag_attributes[2].gsub('"', '').strip : ''
              end
              @tag_attributes[k] = v
            end

            tag_id = element.match(/\#(.*)/)
            @tag_id = tag_id[1].strip.gsub('\#', '') if tag_id
          end
        end

        params = {}
        params[:tag] = @tag
        params[:tag_id] = @tag_id.strip unless @tag_id.nil?
        params[:tag_classes] = @tag_classes.join(' ') unless @tag_classes.empty?
        params[:tag_attributes] = @tag_attributes unless @tag_attributes.nil?
        params[:tag_contents] = @tag_contents unless @tag_contents.nil?

        MarkdownUI::Elements::Tag.new(params).render
      end
    end
  end
end