# coding: UTF-8

module MarkdownUI
  module Message
    class StandardMessage < MarkdownUI::Shared::TagKlass
      def initialize(_content, _klass = nil)
        @_klass   = _klass
        @content = _content
      end

      def render
        @klass = "ui #{@_klass} message"

        # Handle both string and array content
        if @content.is_a?(Array)
          # Content is already an array from the double emphasis renderer
          content_result = MarkdownUI::Content::Parser.new(@content).parse
          # Wrap the content in the message div
          MarkdownUI::StandardTag.new(content_result, klass_text).render
        elsif @content && !@content.include?(':')
          # Simple text content - use directly
          MarkdownUI::StandardTag.new(@content, klass_text).render
        else
          # Structured content - parse the content string into an array first
          # Split on commas to get individual content items
          content_items = @content.split(',')
          content_result = MarkdownUI::Content::Parser.new(content_items).parse
          # Wrap the content in the message div
          MarkdownUI::StandardTag.new(content_result, klass_text).render
        end
      end
    end
  end
end
