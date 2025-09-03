# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for item UI elements (grouped content items)
    class ItemElement < BaseElement
      
      def render
        if @element_name == 'items' || has_modifier?('items')
          # Handle multiple items
          render_multiple_items
        elsif @element_name == 'item'
          # Handle single item
          item_content, item_header, item_meta, item_image = extract_item_content
          build_item_html(item_content, item_header, item_meta, item_image)
        else
          # Fallback for other cases
          item_content, item_header, item_meta, item_image = extract_item_content
          build_item_html(item_content, item_header, item_meta, item_image)
        end
      end
      
      private

      def render_multiple_items
        content_str = @content.is_a?(Array) ? @content.join("\n") : @content.to_s
        item_sections = parse_item_sections(content_str)

        items_html = item_sections.map do |section|
          content, header, meta, image = extract_single_item_content(section)
          build_item_html(content, header, meta, image, use_full_css_class: false)
        end.join("\n")

        # Remove extra blank lines and add proper indentation
        cleaned_html = items_html.gsub(/\n\s*\n/, "\n")
        indented_html = cleaned_html.split("\n").map { |line| line.empty? ? "" : "  #{line}" }.join("\n")

        container_classes = ['ui']
        # Add element name as modifier if it's not 'items' or 'item'
        container_classes << @element_name if @element_name != 'items' && @element_name != 'item'
        # Add all modifiers except 'items' (to avoid duplicates)
        container_classes += @modifiers.reject { |m| m == 'items' }
        # Add 'items' at the end
        container_classes << 'items'
        %[<div class="#{container_classes.uniq.join(' ')}">\n#{indented_html}\n</div>\n]
      end

      def parse_item_sections(content_str)
        lines = content_str.split("\n")
        sections = []
        current_section = []

        lines.each do |line|
          # Strip blockquote markers and check for "Item:"
          stripped_line = line.strip.sub(/^>+\s*/, '')
          if stripped_line.start_with?("Item:")
            # Start of a new item section
            sections << current_section.join("\n") unless current_section.empty?
            current_section = [line]
          else
            current_section << line unless current_section.empty?
          end
        end

        # Add the last section
        sections << current_section.join("\n") unless current_section.empty?

        sections
      end

      def extract_single_item_content(section_content)
        lines = section_content.split("\n")
        image = ''
        header = ''
        meta = ''
        description = ''

        lines.each do |line|
          # Strip blockquote markers and whitespace
          clean_line = line.strip.sub(/^>+\s*/, '')
          next if clean_line.empty?

          # Remove "Item:" prefix if present
          clean_line = clean_line.sub(/^Item:\s*/, '')

          if clean_line.match?(/^!\[.*\]\(.*\)/)
            # Extract image
            image_match = clean_line.match(/!\[([^\]]*)\]\(([^)]+)\)/)
            if image_match
              image_alt = image_match[1]
              image_src = image_match[2]
              # Store both alt and src
              image = { src: image_src, alt: image_alt }
            end
          elsif clean_line.match?(/^\*\*(.*)\*\*$/)
            # Extract header (bold text)
            header_match = clean_line.match(/^\*\*(.*)\*\*$/)
            header = header_match[1] if header_match
          elsif clean_line.match?(/^\$/)
            # Extract meta (price)
            meta = clean_line.sub(/^\$/, '')
          else
            # Description
            description = clean_line
          end
        end

        [description, header, meta, image]
      end

      def extract_item_content
        content_str = @content.is_a?(Array) ? @content.join("\n") : @content.to_s

        # Check if content contains nested markdown elements
        if content_str.include?('**') || content_str.include?('![') || content_str.include?('$')
          # Parse nested markdown content
          require_relative '../parser'
          parser = MarkdownUI::Parser.new
          parsed_content = parser.parse(content_str)

          # Extract image, header, meta, and description from parsed content
          # Clean the parsed content by removing HTML tags, but preserve line breaks
          clean_content = parsed_content.gsub(/<\/p>/, "\n").gsub(/<br\/?>/i, "\n").gsub(/<[^>]*>/, '').strip

          # Extract components
          lines = clean_content.split("\n")
          image = ''
          header = ''
          meta = ''
          description = ''
          header_set = false

          lines.each do |line|
            line = line.strip
            if line.empty?
              next
            elsif line.match?(/^\$/)
              meta = line.sub(/^\$/, '')
            elsif line.length > 20 || line.match?(/^This/) # Description is typically longer
              description = line
            elsif !header_set && line.match?(/^[A-Z]/) && !line.include?('$')
              header = line
              header_set = true
            end
          end

          # Also try to extract image from HTML
          image_match = parsed_content.match(/<img src="([^"]*)"[^>]*>/)
          image = image_match[1] if image_match

          [description, header, meta, image]
        else
          # Handle simple format
          case @content
          when Array
            content = @content[0].to_s.strip
            header = @content[1].to_s.strip if @content.length > 1
            meta = @content[2].to_s.strip if @content.length > 2
            [content, header || '', meta || '', '']
          when String
            if @content.include?('|')
              parts = @content.split('|')
              content = parts[0].strip
              header = parts[1].strip if parts.length > 1
              meta = parts[2].strip if parts.length > 2
              [content, header || '', meta || '', '']
            else
              [@content.strip, '', '', '']
            end
          else
            ['', '', '', '']
          end
        end
      end
      
      def build_item_html(item_content, item_header, item_meta, item_image, use_full_css_class: true)
        item_html = []

        css_class_to_use = use_full_css_class ? css_class : 'item'
        item_html << %[<div class="#{css_class_to_use}"#{html_attributes}>]

        # Image (if image provided)
        unless item_image.empty?
          item_html << %[  <div class="image">]
          if item_image.is_a?(Hash)
            alt_text = item_image[:alt] || 'Product'
            item_html << %[    <img src="#{escape_html(item_image[:src])}" alt="#{escape_html(alt_text)}" />]
          else
            item_html << %[    <img src="#{escape_html(item_image)}" alt="Product" />]
          end
          item_html << %[  </div>]
        end
        
        # Content section
        item_html << %[  <div class="content">]
        
        # Header
        unless item_header.empty?
          item_html << %[    <div class="header">#{escape_html(item_header)}</div>]
        end
        
        # Meta
        unless item_meta.empty?
          item_html << %[    <div class="meta">$#{escape_html(item_meta)}</div>]
        end
        
        # Description
        unless item_content.empty?
          item_html << %[    <div class="description">]
          item_html << %[      <p>#{escape_html(item_content)}</p>]
          item_html << %[    </div>]
        end
        
        
        item_html << %[  </div>]
        item_html << %[</div>]

        item_html.join("\n") + "\n"
      end
      
      def element_name
        'item'
      end
      
      def css_class
        classes = ['ui']
        
        # Add appearance modifiers
        appearance_modifiers = @modifiers & %w[divided relaxed very relaxed link]
        classes.concat(appearance_modifiers)
        
        classes << 'item'
        classes.join(' ')
      end
    end
  end
end