module MarkdownUI
  module Renderers
    module HorizontalRule
      def hrule
        render_standard_tag
      end

      protected

      def render_standard_tag
        MarkdownUI::StandardTag.new(nil, divider_klass).render
      end

      def divider_klass
        'ui divider'
      end
    end
  end
end