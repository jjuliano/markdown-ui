# coding: UTF-8

module MarkdownUI::Loader
  class Custom
    def initialize(element, content, klass = nil)
      @element = element
      @klass   = klass
      @content = content
    end

    def render
      element = @element.join(' ').strip
      content = @content
      
      klass = build_class(element)
      
      if element.include?('dimmer')
        render_dimmer_loader(content, klass)
      else
        render_standard_loader(content, klass)
      end
    end

    private

    def build_class(element)
      classes = ['ui']

      # Add size classes first
      sizes = %w[mini tiny small medium large big huge massive]
      sizes.each do |size|
        classes << size if element.include?(size)
      end

      # Add state classes
      classes << 'active' if element.include?('active')
      classes << 'disabled' if element.include?('disabled')
      classes << 'inverted' if element.include?('inverted')

      # Add variation classes
      classes << 'centered' if element.include?('centered')
      classes << 'inline' if element.include?('inline')

      # Add text class if content is present and not dimmer, but not for inline loaders
      if @content && !@content.empty? && !element.include?('dimmer')
        classes << 'text' unless element.include?('inline')
      end

      # Always add loader class at the end
      classes << 'loader'

      classes.join(' ')
    end

    def render_dimmer_loader(content, klass)
      # For dimmer loaders, create a simple text loader inside the dimmer
      "<div class=\"ui dimmer\">
  <div class=\"ui text loader\">#{content}</div>
</div>"
    end

    def render_standard_loader(content, klass)
      if content && !content.empty?
        "<div class=\"#{klass}\">#{content}</div>"
      else
        "<div class=\"#{klass}\"></div>"
      end
    end
  end
end