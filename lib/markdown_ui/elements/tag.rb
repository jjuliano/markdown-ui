
require 'byebug'
require_relative 'raw_text'
require_relative 'tag_id'
require_relative 'tag_classes'

module MarkdownUI
  module Elements
    class Tag
      include Erector::Mixin

      PROPERTIES = %i[tag tag_id tag_classes tag_attributes tag_contents].freeze
      PROPERTIES.each do |prop|
        attr_accessor prop
      end

      def initialize(attributes = {})
        attributes.each do |key, value|
          send("#{key}=", value) if PROPERTIES.member? key
        end
      end

      def render
        params = {}
        params[:id] = tag_id
        params[:class] = tag_classes
        params.merge!(tag_attributes) unless tag_attributes.empty?

        parser = MarkdownUI::Parser.new
        content = parser.render(tag_contents)

        erector do
          if tag.nil?
            text tag_contents
          else
            send(tag, tag_contents, params)
          end
        end
      end
    end
  end
end
