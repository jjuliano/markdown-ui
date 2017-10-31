module MarkdownUI
  module Elements
    class RawText
      PROPERTIES = [:text].freeze
      PROPERTIES.each do |prop|
        attr_accessor prop
      end

      def initialize(attributes = {})
        attributes.each do |key, value|
          send("#{key}=", MarkdownUI::Tools::HTMLFormatter.filter_text(value)) if PROPERTIES.member? key
        end
      end

      def to_s
        return if text.nil?
        text
      end
    end
  end
end
