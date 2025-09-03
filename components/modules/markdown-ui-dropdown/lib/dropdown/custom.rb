# coding: UTF-8

module MarkdownUI::Dropdown
  class Custom
    def initialize(element, content, klass = nil)
      @element = element
      @klass   = klass
      @content = content
    end

    def render
      element = @element.join(' ').strip
      
      # Debug output
      # puts "DROPDOWN DEBUG: element=#{element}, content='#{@content}', klass='#{@klass}'"
      
      # Parse content - handle string format with pipes
      if @content.is_a?(String)
        # Parse string format: "placeholder|options|variations"
        parts = @content.split('|')
        placeholder = parts[0] || "Select..."
        options = parts[1] ? parts[1].split(',').map(&:strip) : []
        variations = parts[2] if parts.length > 2
      elsif @content.is_a?(Array) && @content.length >= 2
        placeholder = @content[0]
        options = @content[1].split(',').map(&:strip)
        variations = @content[2] if @content.length > 2
      else
        placeholder = "Select..."
        options = []
        variations = nil
      end
      
      klass = build_class(element, variations, @klass)
      
      render_dropdown(placeholder, options, klass, variations)
    end

    private

    def build_class(element, variations, base_class)
      classes = ['ui']

      # Add variation classes
      if variations
        variations_list = variations.is_a?(String) ? [variations] : variations
        classes << 'selection' if variations_list.any? { |v| v.include?('selection') }
        classes << 'search' if variations_list.any? { |v| v.include?('search') }
        classes << 'multiple' if variations_list.any? { |v| v.include?('multiple') }
        classes << 'fluid' if variations_list.any? { |v| v.include?('fluid') }
        classes << 'loading' if variations_list.any? { |v| v.include?('loading') }
        classes << 'error' if variations_list.any? { |v| v.include?('error') }
        classes << 'disabled' if variations_list.any? { |v| v.include?('disabled') }
      end

      classes << (base_class || 'dropdown')
      classes.join(' ')
    end

    def render_dropdown(placeholder, options, klass, variations)
      menu_items = options.map { |option| "    <div class=\"item\">#{option}</div>" }.join("")
      
      # Adjust placeholder text for disabled state
      if variations && variations.include?('disabled')
        placeholder = "Disabled"
      end
      
      %(<div class="#{klass}">
  <div class="default text">#{placeholder}</div>
  <i class="dropdown icon"></i>
  <div class="menu">
#{menu_items}
  </div>
</div>
)
    end
  end
end