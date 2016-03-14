# coding: UTF-8

module MarkdownUI
  module Elements
    class Base
      PROPERTIES = [:tag_id, :tag_classes, :tag_attributes, :tag_contents]
      PROPERTIES.each { |prop|
        attr_accessor prop
      }

      def initialize(attributes = {})
        attributes.each { |key, value|
          self.send("#{key}=", value) if PROPERTIES.member? key
        }
      end
      
      def render
      end
    end
  end
end