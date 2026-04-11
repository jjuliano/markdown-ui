module MarkdownUI
  module Renderers
    module Dropdown
      def dropdown(text, items = [], options = {})
        html do
          classes = ['ui']
          classes << options[:type] if options[:type] # selection, multiple, search, inline
          classes << 'dropdown'

          dropdown_html = "<div class='#{classes.join(' ')}'>"

          if options[:type] == 'selection'
            dropdown_html << "<input type='hidden' name='#{options[:name] || 'dropdown'}'>"
            dropdown_html << "<div class='default text'>#{text}</div>"
          else
            dropdown_html << "<div class='text'>#{text}</div>"
          end

          dropdown_html << "<i class='dropdown icon'></i>"
          dropdown_html << "<div class='menu'>"

          if items.is_a?(Array)
            items.each do |item|
              if item.is_a?(Hash)
                dropdown_html << "<div class='item' data-value='#{item[:value]}'>#{item[:text]}</div>"
              else
                dropdown_html << "<div class='item' data-value='#{item}'>#{item}</div>"
              end
            end
          else
            dropdown_html << items
          end

          dropdown_html << "</div></div>"
          dropdown_html
        end
      end
    end
  end
end