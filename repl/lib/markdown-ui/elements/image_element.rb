# frozen_string_literal: true

require_relative 'base_element'

module MarkdownUI
  module Elements
    # Handler for image UI elements
    class ImageElement < BaseElement
      
      def render
        src = extract_src
        alt_text = extract_alt_text
        
        return '' if src.empty?
        
        build_image_html(src, alt_text)
      end
      
      private
      
      def extract_src
        case @content
        when Array
          # Look for URL in content
          url_item = @content.find { |item| item.to_s.match?(/^https?:\/\/|^\/|^\w+\.\w+/) }
          url_item.to_s.strip if url_item
        when String
          if @content.include?('|')
            # Format: "src|alt text"
            @content.split('|').first.to_s.strip
          else
            @content.strip
          end
        else
          ''
        end || ''
      end
      
      def extract_alt_text
        case @content
        when Array
          # Look for non-URL content as alt text
          alt_item = @content.find { |item| !item.to_s.match?(/^https?:\/\/|^\/|^\w+\.\w+/) }
          alt_candidate = alt_item.to_s.strip if alt_item
          
          # If alt text looks like modifiers, treat it as modifiers instead
          if alt_candidate && looks_like_modifiers?(alt_candidate)
            # Add words as modifiers
            alt_candidate.split.each { |word| @modifiers << word.downcase unless @modifiers.include?(word.downcase) }
            '' # No alt text
          else
            alt_candidate || ''
          end
        when String
          if @content.include?('|')
            alt_candidate = @content.split('|')[1].to_s.strip
            
            # If alt text looks like modifiers, treat it as modifiers instead  
            if looks_like_modifiers?(alt_candidate)
              alt_candidate.split.each { |word| @modifiers << word.downcase unless @modifiers.include?(word.downcase) }
              '' # No alt text
            else
              alt_candidate
            end
          else
            '' # No alt text provided
          end
        else
          ''
        end || ''
      end
      
      def looks_like_modifiers?(text)
        return false if text.nil? || text.empty?
        
        # Check if all words in the text are valid image modifiers
        words = text.split
        return false if words.empty?
        
        image_modifiers = %w[fluid avatar bordered circular rounded spaced floated centered]
        words.all? { |word| image_modifiers.include?(word.downcase) }
      end
      
      def build_image_html(src, alt_text)
        img_attrs = []
        img_attrs << %[src="#{escape_html(src)}"]
        img_attrs << %[alt="#{escape_html(alt_text)}"] unless alt_text.empty?
        
        # Determine if it should be wrapped
        if wrapped_image?
          %[<div class="#{css_class}"#{html_attributes}>
  <img #{img_attrs.join(' ')} />
</div>\n]
        else
          img_classes = ['ui']
          img_classes.concat(@modifiers)
          img_classes << 'image'

          %[<img class="#{img_classes.join(' ')}" #{img_attrs.join(' ')}#{html_attributes} />\n]
        end
      end
      
      def wrapped_image?
        # Most image types should apply classes directly to img tag, not use wrappers
        # Only wrap for complex layouts that truly need container divs
        wrapper_modifiers = %w[floated group]
        (@modifiers & wrapper_modifiers).any?
      end
      
      def element_name
        'image'
      end
      
      def css_class
        classes = ['ui']
        
        # Add size modifiers
        size_modifiers = @modifiers & %w[mini tiny small medium large big huge massive]
        classes.concat(size_modifiers)
        
        # Add appearance modifiers
        appearance_modifiers = @modifiers & %w[fluid avatar bordered circular rounded spaced disabled]
        classes.concat(appearance_modifiers)
        
        # Add alignment modifiers
        alignment_modifiers = @modifiers & %w[centered left floated right floated top aligned middle aligned bottom aligned]
        classes.concat(alignment_modifiers)
        
        classes << 'image'
        classes.join(' ')
      end
    end
  end
end