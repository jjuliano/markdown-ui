# coding: UTF-8

module MarkdownUI
  module Elements
    class RawText
      PROPERTIES = [:text]
      PROPERTIES.each { |prop|
        attr_accessor prop
      }

      def initialize(attributes = {})
        attributes.each { |key, value|
          self.send("#{key}=", MarkdownUI::Tools::HTMLFormatter.filter_text(value)) if PROPERTIES.member? key
        }
      end
      
      def to_s
        return if self.text.nil?
        self.text
      end
    end
  end
end