# coding: UTF-8
require_relative 'raw_text'

module MarkdownUI
  module Elements
    class TagID
      PROPERTIES = [:tag_id]
      PROPERTIES.each { |prop|
        attr_accessor prop
      }

      def initialize(attributes = {})
        attributes.each { |key, value|
          self.send("#{key}=", MarkdownUI::Elements::RawText.new(text: value).to_s) if PROPERTIES.member? key
        }
      end
      
      def to_s
        return if self.tag_id.nil?
        self.tag_id.strip
      end
    end
  end
end