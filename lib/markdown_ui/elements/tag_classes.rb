
require_relative 'raw_text'

module MarkdownUI
  module Elements
    class TagClasses
      PROPERTIES = [:tag_classes].freeze
      PROPERTIES.each do |prop|
        attr_accessor prop
      end

      def initialize(attributes = {})
        attributes.each do |key, value|
          send("#{key}=", MarkdownUI::Elements::RawText.new(text: value.join(' ')).to_s) if PROPERTIES.member? key
        end
      end

      def to_s
        return if tag_classes.nil?
        tag_classes.strip
      end
    end
  end
end
