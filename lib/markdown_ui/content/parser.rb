# coding: UTF-8
require 'ostruct'

module MarkdownUI
  module Content
    class Parser
      def initialize(content = nil)
        @content = content
      end

      def parse
        return [nil,nil] if @content.nil?

        if @content.is_a? Array
          final_content = []

          @content.each do |c|
            content = c.split(":")
            final_content << process(content)
          end

          final_content.join
        else
          content = @content.split(":")
          process(content)
        end

      end

      def process(content)
        content_type, actual_content = content[0], content[1]
        klass = content[2] if content.size > 2

        mode = OpenStruct.new(
          :text?    => !(content_type =~ /text/i).nil?,
          :icon?    => !(content_type =~ /icon/i).nil?,
          :flag?    => !(content_type =~ /flag/i).nil?,
          :image?   => !(content_type =~ /image/i).nil?
        )

        return MarkdownUI::Content::Text.new(actual_content, klass).render if mode.text?
        return MarkdownUI::Content::Icon.new(actual_content, klass).render if mode.icon?
      end

    end
  end
end