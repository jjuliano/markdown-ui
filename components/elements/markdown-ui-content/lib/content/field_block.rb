# coding: UTF-8

module MarkdownUI
  module Content
    class FieldBlock
      def initialize(element, content)
        @element = element
        @content = content
      end

      def render
        element_class = @element.is_a?(Array) ? @element.join(' ').downcase : @element.to_s.downcase
        field_class = element_class == "field" ? "field" : "#{element_class} field"
        label_text = @content.strip

        # For now, just create the field with label - the FormBlock will handle input placement
        %(<div class="#{field_class}">
    <label>#{label_text}</label>
  </div>)
      end
    end
  end
end
