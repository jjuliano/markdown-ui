# coding: UTF-8

module MarkdownUI::Label
  class Custom
    def initialize(element, content, klass = nil)
      @element = element
      @klass   = klass
      @content = content
    end

    def render
      # Remove 'label' from element parts since it's added at the end
      element_parts = @element.is_a?(Array) ? @element.dup : [@element]
      element_parts.delete('label')
      element_parts.delete('Label')
      
      element = element_parts.join(' ').strip
      content = @content
      options = @klass || ""
      
      # Handle special label types
      if options.start_with?('image ')
        render_image_label(content, options)
      elsif options == 'corner'
        render_corner_label(options)
      elsif options.start_with?('detail ')
        render_detail_label(content, options)
      elsif options.start_with?('icon ')
        render_icon_label(content, options)
      else
        # Standard label
        klass = "ui #{options} #{element} label".squeeze(' ').strip
        parsed_content = MarkdownUI::Content::Parser.new(content).parse
        MarkdownUI::StandardTag.new(parsed_content, klass).render
      end
    end

    private

    def render_image_label(content, options)
      # Extract image URL from "image https://..."
      url = options.split(' ', 2)[1]

      "<div class=\"ui image label\">
  <img src=\"#{url}\" />
  #{content}
</div>"
    end

    def render_corner_label(options)
      klass = "ui corner label"
      label_content = "<i class=\"icon\"></i>"
      MarkdownUI::StandardTag.new(label_content, klass).render
    end

    def render_detail_label(content, options)
      # Extract detail value from "detail 23"
      detail_value = options.split(' ', 2)[1]
      klass = "ui label"

      "<div class=\"#{klass}\">#{content}<div class=\"detail\">#{detail_value}</div></div>"
    end

    def render_icon_label(content, options)
      # Extract icon name from "icon mail"
      icon_name = options.split(' ', 2)[1]
      klass = "ui label"

      "<div class=\"#{klass}\"><i class=\"#{icon_name} icon\"></i>#{content}</div>"
    end
  end
end
