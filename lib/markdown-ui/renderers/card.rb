module MarkdownUI
  module Renderers
    module Card
      def card(content = nil, options = {})
        html do
          classes = ['ui']
          classes << options[:color] if options[:color]
          classes << options[:size] if options[:size] # tiny, small, large, huge
          classes << 'card'

          if options[:group]
            # Cards group wrapper
            "<div class='ui cards'>#{content}</div>"
          elsif content
            # Single card
            "<div class='#{classes.join(' ')}'>#{content}</div>"
          else
            # Card wrapper for structured content
            "<div class='#{classes.join(' ')}'>"
          end
        end
      end

      def card_image(src, alt = nil, options = {})
        html do
          classes = ['image']
          classes << options[:alignment] if options[:alignment] # left, right

          "<div class='#{classes.join(' ')}'>
            <img src='#{src}' alt='#{alt}'>
          </div>"
        end
      end

      def card_content(content, options = {})
        html do
          classes = ['content']
          classes << 'extra' if options[:extra]
          classes << 'meta' if options[:meta]

          "<div class='#{classes.join(' ')}'>#{content}</div>"
        end
      end

      def card_header(text, options = {})
        html do
          "<div class='header'>#{text}</div>"
        end
      end
    end
  end
end