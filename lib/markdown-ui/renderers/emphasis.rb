module MarkdownUI
  module Renderers
    module Emphasis
      def emphasis(text)
        is_icon?(text) ? render_icon(text) : render_flag(text)
      end

      protected

      def render_flag(text)
        MarkdownUI::Content::Flag.new(text).render
      end

      def render_icon(text)
        MarkdownUI::Content::Icon.new(text).render
      end

      def is_icon?(text)
        text =~ /icon/i
      end
    end
  end
end