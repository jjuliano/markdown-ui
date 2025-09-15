module MarkdownUI
  module Renderers
    module Progress
      def progress(percent = 0, label = nil, options = {})
        html do
          classes = ['ui']
          classes << options[:color] if options[:color] # red, blue, green, etc.
          classes << options[:state] if options[:state] # active, success, error, warning
          classes << options[:size] if options[:size] # tiny, small, large, big
          classes << 'progress'

          data_attrs = {}
          data_attrs['data-percent'] = percent if percent

          progress_html = "<div class='#{classes.join(' ')}'"
          data_attrs.each { |k, v| progress_html << " #{k}='#{v}'" }
          progress_html << ">"

          progress_html << "<div class='bar' style='width: #{percent}%'></div>"
          progress_html << "<div class='label'>#{label}</div>" if label
          progress_html << "</div>"

          progress_html
        end
      end
    end
  end
end