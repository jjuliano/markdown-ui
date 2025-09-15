module MarkdownUI
  module Renderers
    module Accordion
      def accordion(content, title = nil, options = {})
        html do
          classes = ['ui', 'accordion']
          classes << options[:style] if options[:style] # styled, fluid, inverted

          if title && content
            # Single section accordion
            "<div class='#{classes.join(' ')}'>
              <div class='title'>#{title}</div>
              <div class='content'>#{content}</div>
            </div>"
          else
            # Multi-section accordion wrapper
            "<div class='#{classes.join(' ')}'>#{content}</div>"
          end
        end
      end
    end
  end
end