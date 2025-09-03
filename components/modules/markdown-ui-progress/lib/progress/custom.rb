# coding: UTF-8

module MarkdownUI::Progress
  class Custom
    def initialize(element, content, klass = nil, id = nil, data_attributes = nil)
      @element = element
      @klass   = klass
      @content = content
      @id      = id
      @data_attributes = data_attributes
    end

    def render
      # Parse arguments based on the format:
      # __Progress|percentage__ -> content is percentage
      # __Progress|label|percentage|options__ -> content is label, klass is percentage, data_attributes is options

      label = nil
      percentage = 0
      options = @data_attributes

      if @content && @content.match?(/^\d+$/)
        # Simple format: __Progress|75__
        percentage = @content.to_i
      elsif @klass && @klass.match?(/^\d+$/)
        # Full format: __Progress|label|percentage|options__
        label = @content
        percentage = @klass.to_i
      elsif @content && @content != "Progress"
        # Label only format: __Progress|label|options__
        label = @content
        percentage = 0
      else
        # Try to find percentage in data_attributes or other parameters
        # For format: __Progress|label|percentage|options__
        if @data_attributes && @data_attributes.match?(/^\d+$/)
          percentage = @data_attributes.to_i
          label = @content
        else
          label = @content
          percentage = 0
        end
      end

      klass = build_class(options)

      render_progress(label, percentage, klass, options)
    end

    private

    def build_class(options)
      classes = ['ui']
      
      # Add state classes from options
      if options
        classes << 'indicating' if options.include?('indicating')
        classes << 'success' if options.include?('success')
        classes << 'warning' if options.include?('warning')
        classes << 'error' if options.include?('error')
        classes << 'active' if options.include?('active')
        classes << 'disabled' if options.include?('disabled')
        classes << 'inverted' if options.include?('inverted')
        classes << 'attached' if options.include?('attached')
        
        # Size classes
        sizes = %w[tiny small medium large big]
        sizes.each do |size|
          classes << size if options.include?(size)
        end
      end
      
      classes << 'progress'
      classes.join(' ')
    end

    def render_progress(label, percentage, klass, options)
      bar_content = should_show_progress?(label, options) ? %(
    <div class="progress">#{percentage}%</div>) : ""
      
      # Don't show label for attached progress or when label is just the percentage
      show_label = label && !(options && options.include?('attached'))
      label_content = show_label ? %(
  <div class="label">#{label}</div>) : ""
      
      # Format the bar div based on whether it has content
      if bar_content.empty?
        bar_div = %(<div class="bar" style="width: #{percentage}%"></div>)
      else
        bar_div = %(<div class="bar" style="width: #{percentage}%">#{bar_content}
  </div>)
      end
      
      %(<div class="#{klass}" data-percent="#{percentage}">
  #{bar_div}#{label_content}
</div>
)
    end

    def should_show_progress?(label, options)
      return false if options && options.include?('attached')
      return false if options && options.include?('disabled')
      # Don't show progress text for size-based progress bars
      return false if options && (options.include?('tiny') || options.include?('small') || options.include?('medium') || options.include?('large') || options.include?('big'))
      # Show progress text for indicating progress bars and when there's a label (but not for simple percentage-only bars)
      return true if options && options.include?('indicating')
      return true if label && label != "Progress" && !label.match?(/^\d+$/)
      false
    end
  end
end