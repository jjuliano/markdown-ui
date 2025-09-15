module MarkdownUI
  module Renderers
    module Checkbox
      def checkbox(name, label, options = {})
        html do
          classes = ['ui']
          classes << options[:type] if options[:type] # radio, slider, toggle
          classes << 'checkbox'

          checkbox_id = options[:id] || "checkbox_#{name}"

          checkbox_html = "<div class='#{classes.join(' ')}'>"
          checkbox_html << "<input type='#{options[:type] == 'radio' ? 'radio' : 'checkbox'}' "
          checkbox_html << "id='#{checkbox_id}' name='#{name}'"
          checkbox_html << " value='#{options[:value]}'" if options[:value]
          checkbox_html << " checked" if options[:checked]
          checkbox_html << " disabled" if options[:disabled]
          checkbox_html << ">"
          checkbox_html << "<label for='#{checkbox_id}'>#{label}</label>"
          checkbox_html << "</div>"

          checkbox_html
        end
      end
    end
  end
end