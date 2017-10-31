
require_relative 'raw_text'

module MarkdownUI
  module Elements
    class TagID
      PROPERTIES = [:tag_id].freeze
      PROPERTIES.each do |prop|
        attr_accessor prop
      end

      def initialize(attributes = {})
        attributes.each do |key, value|
          send("#{key}=", MarkdownUI::Elements::RawText.new(text: value).to_s) if PROPERTIES.member? key
        end
      end

      def to_s
        return if tag_id.nil?
        tag_id.strip
      end
    end
  end
end
