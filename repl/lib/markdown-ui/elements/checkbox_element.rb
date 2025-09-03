# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for checkbox UI elements
    class CheckboxElement < BaseElement
      
      def render
        label_text = extract_label_text
        checkbox_id = generate_checkbox_id
        
        build_checkbox_html(label_text, checkbox_id)
      end
      
      private
      
      def extract_label_text
        case @content
        when Array
          @content.join(' ').strip
        when String
          @content.strip
        else
          ''
        end
      end
      
      def generate_checkbox_id
        # Generate a unique ID for the checkbox
        base_id = extract_label_text.downcase.gsub(/\W/, '_').gsub(/_+/, '_')
        base_id = base_id.sub(/^_+/, '').sub(/_+$/, '') # Remove leading/trailing underscores
        base_id.empty? ? "checkbox_#{Random.rand(1000)}" : "#{base_id}_checkbox"
      end
      
      def build_checkbox_html(label_text, checkbox_id)
        checkbox_html = []
        
        checkbox_html << %[<div class="#{css_class}"#{html_attributes}>]
        
        # Add checkbox input
        checkbox_attrs = []
        checkbox_attrs << %[type="checkbox"]
        checkbox_attrs << %[id="#{checkbox_id}"]
        
        # Add checked state if specified
        if has_modifier?('checked')
          checkbox_attrs << %[checked="checked"]
        end
        
        # Add disabled state if specified  
        if has_modifier?('disabled')
          checkbox_attrs << %[disabled="disabled"]
        end
        
        checkbox_html << %[  <input #{checkbox_attrs.join(' ')} />]
        
        # Add label
        unless label_text.empty?
          checkbox_html << %[  <label for="#{checkbox_id}">#{escape_html(label_text)}</label>]
        end
        
        checkbox_html << %[</div>]
        
        checkbox_html.join("\n")
      end
      
      def element_name
        'checkbox'
      end
      
      def css_class
        classes = ['ui']
        
        # Add state modifiers (except checked/disabled which go on input)
        state_modifiers = @modifiers & %w[fitted indeterminate]
        classes.concat(state_modifiers)
        
        # Add type modifiers
        type_modifiers = @modifiers & %w[radio slider toggle]
        classes.concat(type_modifiers)
        
        classes << 'checkbox'
        classes.join(' ')
      end
    end
  end
end