# coding: UTF-8

module MarkdownUI
  module Form
    class Element
      def initialize(element, content, klass = nil)
        @element = element
        @content = content
        @klass   = klass
      end

      def render
        # Parse the form content - expect format: "Field|Label,Input|Placeholder,Button|Text|Class"
        if @content.is_a?(Array) && @content.length >= 1
          # Process each content item
          form_elements = []
          
          @content.each do |item|
            if item.include?('|')
              parts = item.split('|')
              element_type = parts[0].strip
              element_content = parts[1..-1]
              
              case element_type.downcase
              when 'field'
                form_elements << render_field(element_content)
              when 'input'
                form_elements << render_input(element_content)
              when 'button'
                form_elements << render_button(element_content)
              when 'message'
                form_elements << render_message(element_content)
              end
            end
          end
          
          # Build the form class
          form_class = build_form_class
          
          # Generate the form HTML
          "<form class=\"#{form_class}\">#{form_elements.join("")}</form>"
        else
          ""
        end
      end

      private

      def build_form_class
        classes = ['ui']
        
        if @klass
          # Add variation classes from klass
          klass_words = @klass.split(' ')
          classes.concat(klass_words)
        end
        
        classes << 'form'
        classes.join(' ')
      end

      def render_field(content)
        if content && content.length > 0
          label = content[0].strip
          "<div class=\"field\"><label>#{label}</label></div>"
        else
          "<div class=\"field\"></div>"
        end
      end

      def render_input(content)
        if content && content.length > 0
          placeholder = content[0].strip
          input_class = content[1] if content.length > 1
          
          # Build input class
          input_classes = ['ui']
          input_classes << input_class if input_class
          input_classes << 'input'
          
          "<div class=\"#{input_classes.join(' ')}\"><input type=\"text\" placeholder=\"#{placeholder}\" /></div>"
        else
          "<div class=\"ui input\"><input type=\"text\" /></div>"
        end
      end

      def render_button(content)
        if content && content.length > 0
          text = content[0].strip
          button_class = content[1] if content.length > 1
          
          # Build button class
          button_classes = ['ui']
          button_classes << button_class if button_class
          button_classes << 'button'
          
          "<button class=\"#{button_classes.join(' ')}\">#{text}</button>"
        else
          "<button class=\"ui button\">Button</button>"
        end
      end

      def render_message(content)
        if content && content.length > 0
          message_type = content[0].strip
          message_text = content[1] if content.length > 1
          
          # Build message class
          message_classes = ['ui']
          message_classes << message_type if message_type
          message_classes << 'message'
          
          if message_text
            "<div class=\"#{message_classes.join(' ')}\"><div class=\"header\">#{message_type.capitalize}</div><p>#{message_text}</p></div>"
          else
            "<div class=\"#{message_classes.join(' ')}\">#{message_type.capitalize}</div>"
          end
        else
          "<div class=\"ui message\">Message</div>"
        end
      end
    end
  end
end

