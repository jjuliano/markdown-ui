# coding: UTF-8
require 'ostruct'

module MarkdownUI
  module Content
    class Parser
      def initialize(content = nil)
        @content = content
      end

      def parse
        if @content.is_a? Array
          final_content = []

          @content.each do |c|
            content = c.split(':')
            final_content << process(content)
          end

          final_content.join
        else
          content = if !(@content =~ /\:/).nil?
            @content.split(':')
          else
            if @content
              @content.split('\n')
            else
              ['']
            end
          end

          process(content)
        end
      end

      def process(content)
        content_type, actual_content = content[0], content[1]
        klass = content[2] if content.size > 2

        if actual_content
          mode = OpenStruct.new(
            :text?      => !(content_type =~ /text/i).nil?,
            :icon?      => !(content_type =~ /icon/i).nil?,
            :flag?      => !(content_type =~ /flag/i).nil?,
            :image?     => !(content_type =~ /image/i).nil?,
            :header?    => !(content_type =~ /header/i).nil?,
            :list?      => !(content_type =~ /list/i).nil?,
            :unordered? => !(content_type =~ /unordered/i).nil?,
            :ordered?   => !(content_type =~ /ordered/i).nil?
          )

          if mode.text?
            MarkdownUI::Content::Text.new(actual_content, klass).render
          elsif mode.icon?
            MarkdownUI::Content::Icon.new(actual_content, klass).render
          elsif mode.flag?
            MarkdownUI::Content::Flag.new(actual_content, klass).render
          elsif mode.header?
            MarkdownUI::Content::Header.new(actual_content, klass).render
          elsif mode.list? && mode.ordered?
            MarkdownUI::Content::List.new(actual_content, klass, :ordered).render
          elsif mode.list? && mode.unordered?
            MarkdownUI::Content::List.new(actual_content, klass, :unordered).render
          elsif mode.list?
            MarkdownUI::Content::List.new(actual_content, klass).render
          else
            MarkdownUI::Content::Custom.new(content.join(' '), klass).render
          end
        else
          MarkdownUI::Content::Custom.new(content.join(' '), klass).render
        end
      end

    end
  end
end
