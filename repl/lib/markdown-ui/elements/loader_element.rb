# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for loader UI elements
    class LoaderElement < BaseElement
      
      def render
        # Extract modifiers from content first
        extract_modifiers_from_content

        loader_text = extract_loader_text

        build_loader_html(loader_text)
      end
      
      private
      
      def extract_modifiers_from_content
        return unless @content.is_a?(Array)

        loader_modifiers = %w[centered inline mini tiny small medium large big huge massive active indeterminate disabled inverted dimmer]

        @content.each do |part|
          words = part.split
          modifier_words = words.select { |word| loader_modifiers.include?(word) }
          @modifiers.concat(modifier_words) unless modifier_words.empty?
        end
      end

      def extract_loader_text
        case @content
        when Array
          # Filter out modifier-like content and join the rest
          text_parts = @content.reject do |part|
            # Check if this part looks like modifiers (contains known loader modifiers)
            loader_modifiers = %w[centered inline mini tiny small medium large big huge massive active indeterminate disabled inverted dimmer]
            words = part.split
            words.any? { |word| loader_modifiers.include?(word) }
          end
          text_parts.join(' ').strip
        when String
          @content.strip
        else
          ''
        end
      end
      
      def build_loader_html(loader_text)
        if has_modifier?('dimmer')
          # Special handling for dimmer loaders
          %[<div class="ui dimmer">\n  <div class="#{css_class}"#{html_attributes}>#{escape_html(loader_text)}</div>\n</div>]
        elsif loader_text.empty?
          %[<div class="#{css_class}"#{html_attributes}></div>]
        else
          %[<div class="#{css_class}"#{html_attributes}>#{escape_html(loader_text)}</div>]
        end
      end
      
      def element_name
        'loader'
      end
      
      def css_class
        classes = ['ui']

        # Add state modifiers
        state_modifiers = @modifiers & %w[active indeterminate disabled]
        classes.concat(state_modifiers)

        # Add type modifiers (handle multi-word modifiers)
        type_modifiers = []
        @modifiers.each do |mod|
          if mod.include?(' ')
            # Split multi-word modifiers and check each word
            words = mod.split
            type_modifiers.concat(words & %w[inline centered])
          else
            type_modifiers << mod if %w[inline centered].include?(mod)
          end
        end
        classes.concat(type_modifiers)

        # Add size modifiers
        size_modifiers = @modifiers & %w[mini tiny small medium large big huge massive]
        classes.concat(size_modifiers)

        # Add appearance modifiers
        appearance_modifiers = @modifiers & %w[inverted]
        classes.concat(appearance_modifiers)

        # Auto-add 'text' if not inline and has content
        loader_text = extract_loader_text
        has_inline = @modifiers.any? do |mod|
          if mod.include?(' ')
            mod.split.include?('inline')
          else
            mod == 'inline'
          end
        end
        if !has_inline && !loader_text.empty?
          classes << 'text'
        end

        classes << 'loader'
        classes.join(' ')
      end
    end
  end
end