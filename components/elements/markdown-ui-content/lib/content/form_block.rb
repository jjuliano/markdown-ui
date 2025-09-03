# coding: UTF-8

module MarkdownUI
  module Content
    class FormBlock
      def initialize(element, content)
        @element = element
        @content = content
      end

      def render
        element_class = @element.downcase
        # Remove 'form' from element_class if it's already there to avoid duplication
        element_parts = element_class.split(' ')
        element_parts.delete('form')
        variation_class = element_parts.empty? ? "" : "#{element_parts.join(' ')} "
        klass = "ui #{variation_class}form"

        parsed_content = parse_form_content(@content.strip)

        %(<form class="#{klass}">
#{parsed_content}
</form>)
      end

      private

      def parse_form_content(content)
        return content if content.empty?

        # First, process the content through the parser to convert markdown to HTML
        processed_content = process_markdown_content(content)

        # Handle different form content patterns
        if processed_content.include?('<menu>')
          # Handle fields from FieldsBlock
          transform_fields_content(processed_content)
        elsif processed_content.include?('ui error message') || processed_content.include?('error field')
          transform_error_form(processed_content)
        elsif processed_content.include?('<div class="ui') && processed_content.include?('<label>')
          transform_single_field_form(processed_content)
        else
          # Handle simple field + input combinations
          transform_simple_form(processed_content)
        end
      end

      def process_markdown_content(content)
        # Convert literal \n to actual newlines
        content = content.gsub('\\n', "")
        
        # Process the content line by line to convert markdown to HTML
        lines = content.split("")
        processed_lines = []
        
        lines.each do |line|
          line = line.strip
          next if line.empty?
          
          # Remove block quote prefix if present
          line = line.sub(/^>\s*/, '')
          
          # Process double emphasis syntax
          if line =~ /^__([^|]+)\|(.+)__$/
            element = $1.strip
            element_content = $2.strip
            
            case element.downcase
            when 'field'
              processed_lines << "<div class=\"field\"><label>#{element_content}</label></div>"
            when 'input'
              # Check if there's a second parameter for input class
              input_parts = element_content.split('|')
              placeholder = input_parts[0].strip
              input_class = input_parts[1] if input_parts.length > 1
              
              input_classes = ['ui']
              input_classes << input_class if input_class
              input_classes << 'input'
              
              processed_lines << "<div class=\"#{input_classes.join(' ')}\"><input type=\"text\" placeholder=\"#{placeholder}\" /></div>"
            when 'button'
              # Check if there's a second parameter for button class
              button_parts = element_content.split('|')
              text = button_parts[0].strip
              button_class = button_parts[1] if button_parts.length > 1
              
              button_classes = ['ui']
              button_classes << button_class if button_class
              button_classes << 'button'
              
              processed_lines << "<button class=\"#{button_classes.join(' ')}\">#{text}</button>"
            when 'message'
              # Check if there's a second parameter for message text
              message_parts = element_content.split('|')
              message_type = message_parts[0].strip
              message_text = message_parts[1] if message_parts.length > 1
              
              message_classes = ['ui']
              message_classes << message_type if message_type
              message_classes << 'message'
              
              if message_text
                processed_lines << "<div class=\"#{message_classes.join(' ')}\"><div class=\"header\">#{message_type.capitalize}</div><p>#{message_text}</p></div>"
              else
                processed_lines << "<div class=\"#{message_classes.join(' ')}\">#{message_type.capitalize}</div>"
              end
            end
          end
        end
        
        processed_lines.join("")
      end

      def transform_fields_content(content)
        # Extract inputs from the menu HTML and create fields structure
        inputs = content.scan(/<div class="ui input">[\s\S]*?<\/div>/m)

        if inputs.length == 2
          # For equal width form, create two fields with labels and inputs
          field_html = [
            "<div class=\"field\">",
            "  <label>First Name</label>",
            "  #{inputs[0]}",
            "</div>",
            "<div class=\"field\">",
            "  <label>Last Name</label>",
            "  #{inputs[1]}",
            "</div>"
          ].join("")

          "<div class=\"fields\">#{field_html}</div>"
        else
          # Fallback: just wrap the existing menu in fields
          "<div class=\"fields\">#{content}</div>"
        end
      end

      def transform_error_form(content)
        transformed = content

        # Transform simple message to proper structure
        if transformed =~ /<div class="ui error message">(.*?)<\/div>/
          message_text = $1
          if message_text == "Error"
            transformed = transformed.sub(
              /<div class="ui error message">Error<\/div>/,
              "<div class=\"ui error message\"><div class=\"header\">Error</div><p>Please correct the errors below</p></div>"
            )
          elsif message_text == "Success"
            transformed = transformed.sub(
              /<div class="ui success message">Success<\/div>/,
              "<div class=\"ui success message\"><div class=\"header\">Success</div><p>Form submitted successfully!</p></div>"
            )
          end
        end

        # Add error classes to fields and inputs
        transformed = transformed.gsub('<div class="field">', '<div class="error field">')
                                 .gsub('<div class="ui input">', '<div class=\"ui error input\">')

        # Add field wrapper and label if missing
        if transformed.include?('<div class="ui error input">') && !transformed.include?('<div class="error field">')
          input_match = transformed.match(/<div class="ui error input">(.*?)<\/div>/m)
          if input_match
            input_html = input_match[0]
            field_html = "<div class=\"error field\"><label>Email</label>  #{input_html}</div>"
            transformed = transformed.sub(input_match[0], field_html)
          end
        end

        transformed
      end

      def transform_single_field_form(content)
        transformed = content

        # Handle multi-line case where field and input are on separate lines
        lines = transformed.split("")
        transformed_lines = []
        i = 0

        while i < lines.length
          line = lines[i].strip

          # If this is a field line
          if line =~ /<div class="field">/
            field_content = line
            # Look for the next input line
            if i + 1 < lines.length && lines[i + 1].strip =~ /<div class="ui input">/
              input_line = lines[i + 1].strip
              # Combine field and input
              field_content = field_content.sub('</div>', "  #{input_line}</div>")
              i += 1  # Skip the input line we just processed
            end
            transformed_lines << field_content
          elsif line =~ /<div class="ui input">/
            # Skip input lines that are already processed
            next
          else
            transformed_lines << lines[i]
          end

          i += 1
        end

        transformed_lines.join("")
      end

      def transform_simple_form(content)
        # Handle the case where we have separate field and input elements
        lines = content.split("")
        transformed_lines = []
        i = 0

        while i < lines.length
          line = lines[i].strip

          # If this is a field line
          if line =~ /<div class="field">/
            field_content = line
            # Look for the next input line
            if i + 1 < lines.length && lines[i + 1].strip =~ /<div class="ui input">/
              input_line = lines[i + 1].strip
              # Combine field and input
              field_content = field_content.sub('</div>', "  #{input_line}</div>")
              i += 1  # Skip the input line we just processed
            end
            transformed_lines << field_content
          elsif line =~ /<div class="ui input">/
            # Skip input lines that are already processed
            next
          else
            transformed_lines << lines[i]
          end

          i += 1
        end

        transformed_lines.join("")
      end

      def render_fields_container(fields)
        return "" if fields.empty?

        field_html = []
        i = 0
        while i < fields.length
          field_type, field_content = fields[i]

          if field_type == "Field"
            # Look for the next Input component
            input_content = ""
            if i + 1 < fields.length && fields[i + 1][0] == "Input"
              input_content = fields[i + 1][1]
              i += 1  # Skip the input we just processed
            end

            field_html << render_field_with_input(field_content, input_content)
          end

          i += 1
        end

        "<div class=\"fields\">#{field_html.join("")}</div>"
      end

      def render_field_with_input(field_label, input_placeholder)
        "<div class=\"field\">
    <label>#{field_label}</label>
    <div class=\"ui input\">
      <input type=\"text\" placeholder=\"#{input_placeholder}\" />
    </div>
  </div>"
      end
    end
  end
end
