# coding: UTF-8
require_relative 'raw_text'

module MarkdownUI
  module Elements
    class TagClasses
      PROPERTIES = [:tag_classes]
      PROPERTIES.each { |prop|
        attr_accessor prop
      }

      def initialize(attributes = {})
        attributes.each { |key, value|
          self.send("#{key}=", MarkdownUI::Elements::RawText.new(text: value.join(' ')).to_s) if PROPERTIES.member? key
        }
      end
      
      def to_s
        return if self.tag_classes.nil?
        self.tag_classes.strip
      end
    end
  end
end