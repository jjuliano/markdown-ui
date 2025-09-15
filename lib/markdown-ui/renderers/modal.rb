module MarkdownUI
  module Renderers
    module Modal
      def modal(id, header = nil, content = nil, actions = nil, options = {})
        html do
          classes = ['ui']
          classes << options[:size] if options[:size] # mini, tiny, small, large, fullscreen
          classes << options[:style] if options[:style] # basic, longer
          classes << 'modal'

          modal_html = "<div id='#{id}' class='#{classes.join(' ')}'>"

          modal_html << "<div class='header'>#{header}</div>" if header

          if content
            content_classes = ['content']
            content_classes << 'scrolling' if options[:scrolling]
            modal_html << "<div class='#{content_classes.join(' ')}'>#{content}</div>"
          end

          modal_html << "<div class='actions'>#{actions}</div>" if actions
          modal_html << "</div>"

          modal_html
        end
      end
    end
  end
end