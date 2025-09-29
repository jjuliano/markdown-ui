module MarkdownUI
  module Renderers
    module Image
      def image(link, title, alt_text)
        title_attr = title && !title.empty? ? " title='#{title}'" : ""
        html { "<img class='ui image' src='#{link}' alt='#{alt_text}'#{title_attr}>" }
      end
    end
  end
end