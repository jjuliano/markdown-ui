# coding: UTF-8

module MarkdownUI::Table
  class Custom
    def initialize(element, content, klass = nil)
      @element = element
      @klass   = klass
      @content = content
    end

    def render
      element = @element.join(' ').strip.downcase
      
      
      # Parse table content - expect format: "headers|row1|row2|...|options"
      if @content.is_a?(Array) && @content.length >= 2
        headers = @content[0].split(',').map(&:strip)
        rows_data = @content[1..-1]
        
        # Check if last element is options (not a data row)
        if rows_data.last && !rows_data.last.include?(',')
          options = rows_data.pop
        else
          options = nil
        end
        
        rows = rows_data.map { |row| row.split(',').map(&:strip) }
      else
        return ""
      end
      
      klass = build_class(element, options)
      
      render_table(headers, rows, klass, options)
    end

    private

    def build_class(element, options)
      classes = ['ui']
      
      # Add variation classes from options
      if options
        # Handle compound options by splitting and adding in order
        option_words = options.split(' ')
        
        # Add modifiers first
        classes << 'very' if option_words.include?('very')
        
        # Add main variations
        classes << 'definition' if option_words.include?('definition')
        classes << 'striped' if option_words.include?('striped')
        classes << 'celled' if option_words.include?('celled')
        classes << 'basic' if option_words.include?('basic')
        classes << 'collapsing' if option_words.include?('collapsing')
        classes << 'fixed' if option_words.include?('fixed')
        classes << 'inverted' if option_words.include?('inverted')
        
        # Color classes
        colors = %w[positive negative warning]
        colors.each do |color|
          classes << color if option_words.include?(color)
        end
      end
      
      classes << 'table'
      classes.join(' ')
    end

    def render_table(headers, rows, klass, options)
      row_class = determine_row_class(options)

      # Generate HTML structure with proper newlines
      header_row = headers.map { |header| "<th>#{header}</th>" }.join("")
      thead = "<thead><tr>#{header_row}</tr></thead>"

      body_rows = rows.map do |row|
        cells = row.map { |cell| "<td>#{cell}</td>" }.join("")
        if row_class
          "<tr class=\"#{row_class}\">#{cells}</tr>"
        else
          "<tr>#{cells}</tr>"
        end
      end.join("")

      tbody = "<tbody>#{body_rows}</tbody>"

      "<table class=\"#{klass}\">#{thead}#{tbody}</table>"
    end

    def determine_row_class(options)
      return 'positive' if options && options.include?('positive')
      return 'negative' if options && options.include?('negative')
      return 'warning' if options && options.include?('warning')
      nil
    end
  end
end