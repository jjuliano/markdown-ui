# coding: UTF-8

module MarkdownUI::Image
  class Custom
    def initialize(element, content, klass = nil, alt_text = nil)
      @element = element
      @klass   = klass
      @content = content
      @alt_text = alt_text
    end

    def render
      element = @element.is_a?(Array) ? @element.join(' ').strip : @element.to_s
      content = @content

      # Parse content for src attribute
      # Content can be just the src URL, or it can contain src|alt format
      if content.is_a?(String) && !content.empty?
        if content.include?('|')
          parts = content.split('|')
          src = parts[0].strip
          alt_from_content = parts[1].strip if parts[1]
        else
          src = content.strip
          alt_from_content = nil
        end
      else
        src = ""
        alt_from_content = nil
      end

      # Use alt_text from parameter if available, otherwise from content
      alt_text = @alt_text || alt_from_content || ""

            klass = build_class(element)

      if element.include?('avatar') || klass.include?('avatar')
        render_avatar(src, alt_text, klass)
      elsif element.include?('fluid') || klass.include?('fluid')
        render_fluid_image(src, alt_text, klass)
      else
        render_standard_image(src, alt_text, klass)
      end
    end

    private

    def build_class(element_str)
      element = element_str.is_a?(Array) ? element_str : element_str.split
      classes = ['ui']

      # Add size classes
      sizes = %w[mini tiny small medium large big huge massive]
      sizes.each do |size|
        classes << size if element.include?(size)
      end

      # Add shape classes
      classes << 'circular' if element.include?('circular')
      classes << 'rounded' if element.include?('rounded')

      # Add alignment classes
      classes << 'centered' if element.include?('centered')
      classes << 'floated' if element.include?('floated')
      classes << 'left' if element.include?('left')
      classes << 'right' if element.include?('right')

      # Add state classes
      classes << 'disabled' if element.include?('disabled')
      classes << 'hidden' if element.include?('hidden')

      # Add variation classes
      classes << 'avatar' if element.include?('avatar') || (@klass && @klass.include?('avatar'))
      classes << 'bordered' if element.include?('bordered') || (@klass && @klass.include?('bordered'))
      classes << 'fluid' if element.include?('fluid') || (@klass && @klass.include?('fluid'))
      classes << 'spaced' if element.include?('spaced') || (@klass && @klass.include?('spaced'))

      classes << 'image'
      classes.join(' ')
    end

    def render_avatar(src, alt_text, klass)
      if alt_text.empty?
        "<img class=\"#{klass}\" src=\"#{src}\" />"
      else
        "<img class=\"#{klass}\" src=\"#{src}\" alt=\"#{alt_text}\" />"
      end
    end

    def render_fluid_image(src, alt_text, klass)
      if alt_text.empty?
        "<img class=\"#{klass}\" src=\"#{src}\" />"
      else
        "<img class=\"#{klass}\" src=\"#{src}\" alt=\"#{alt_text}\" />"
      end
    end

    def render_standard_image(src, alt_text, klass)
      if alt_text.empty?
        "<img class=\"#{klass}\" src=\"#{src}\" />"
      else
        "<img class=\"#{klass}\" src=\"#{src}\" alt=\"#{alt_text}\" />"
      end
    end
  end
end