# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for table UI elements
    # Supports formats like: __Table|Name,Age,Job|John,30,Developer|Jane,25,Designer|basic__
    class TableElement < BaseElement
      
      def render
        return '' if @content.empty?
        
        headers, *rows = parse_table_data
        return '' if headers.empty?
        
        build_table(headers, rows)
      end
      
      private
      
      def parse_table_data
        # Content format: ["Name,Age,Job", "John,30,Developer", "Jane,25,Designer"]
        case @content
        when Array
          @content.map { |row| parse_row(row) }
        when String
          [@content].map { |row| parse_row(row) }
        else
          []
        end
      end
      
      def parse_row(row_data)
        return [] if row_data.nil? || row_data.strip.empty?
        
        # Split by comma, but be careful about escaped commas
        row_data.to_s.split(',').map(&:strip)
      end
      
      def build_table(headers, rows)
        table_html = []
        
        # Opening table tag with CSS classes
        table_html << %[<table class="#{css_class}"#{html_attributes}>]
        
        # Table header
        if headers.any?
          table_html << build_thead(headers)
        end
        
        # Table body
        if rows.any? && rows.flatten.any?
          table_html << build_tbody(rows)
        end
        
        # Closing table tag
        table_html << '</table>'

        table_html.join("\n") + "\n"
      end
      
      def build_thead(headers)
        header_html = []
        header_html << '  <thead>'
        header_html << '    <tr>'

        headers.each do |header|
          header_html << "      <th>"
          header_html << escape_html(header)
          header_html << "</th>"
        end

        header_html << '    </tr>'
        header_html << '  </thead>'

        header_html.join("\n")
      end
      
      def build_tbody(rows)
        body_html = []
        body_html << '  <tbody>'
        
        rows.each do |row|
          next if row.empty?
          
          body_html << build_row(row)
        end
        
        body_html << '  </tbody>'
        
        body_html.join("\n")
      end
      
      def build_row(cells)
        row_html = []
        row_class = determine_row_class(cells)
        
        if row_class
          row_html << %[    <tr class="#{row_class}">]
        else
          row_html << '    <tr>'
        end
        
        cells.each do |cell|
          row_html << '      <td>'
          row_html << parse_cell_content(cell)
          row_html << '</td>'
        end
        
        row_html << '    </tr>'
        
        row_html.join("\n")
      end
      
      def determine_row_class(cells)
        # Check if table has row-level modifiers first (these take priority)
        status_keywords = %w[positive negative warning error active disabled]
        row_modifiers = @modifiers & status_keywords
        return row_modifiers.first if row_modifiers.any?

        # Check if any cell contains status indicators
        cells.each do |cell|
          cell_lower = cell.to_s.downcase
          status_keywords.each do |keyword|
            return keyword if cell_lower.include?(keyword)
          end
        end

        nil
      end
      
      def parse_cell_content(cell)
        return '' if cell.nil?

        cell_content = cell.to_s.strip

        # For now, just return the plain text content
        # Cell content transformation may be handled differently in the future
        parse_nested_content(cell_content)
      end
      
      def element_name
        'table'
      end
      
      # Override base CSS class building for tables
      def css_class
        classes = ['ui']

        # Add semantic modifiers (handle multi-word modifiers)
        semantic_modifiers = %w[basic celled striped definition structured stackable unstackable sortable fixed single line padded compact very relaxed collapsing inverted]
        matching_semantic = @modifiers.select do |mod|
          mod.split(/\s+/).all? { |word| semantic_modifiers.include?(word) }
        end
        classes.concat(matching_semantic)

        # Add color modifiers
        color_modifiers = %w[red orange yellow olive green teal blue violet purple pink brown grey black]
        matching_colors = @modifiers.select do |mod|
          mod.split(/\s+/).all? { |word| color_modifiers.include?(word) }
        end
        classes.concat(matching_colors)

        # Add state modifiers
        state_modifiers = %w[loading error positive negative warning]
        matching_states = @modifiers.select do |mod|
          mod.split(/\s+/).all? { |word| state_modifiers.include?(word) }
        end
        classes.concat(matching_states)

        # Add size modifiers
        size_modifiers = %w[mini tiny small large big huge massive]
        matching_sizes = @modifiers.select do |mod|
          mod.split(/\s+/).all? { |word| size_modifiers.include?(word) }
        end
        classes.concat(matching_sizes)

        classes << 'table'

        # Merge with any CSS classes from attributes
        if @attributes && @attributes['class']
          custom_classes = Array(@attributes['class'])
          classes.concat(custom_classes)
        end

        classes.join(' ')
      end
    end
  end
end