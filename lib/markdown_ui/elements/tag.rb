# coding: UTF-8
require 'byebug'
require_relative 'raw_text'
require_relative 'tag_id'
require_relative 'tag_classes'

module MarkdownUI
  module Elements
    class Tag
      include Erector::Mixin
      
      PROPERTIES = [:tag, :tag_id, :tag_classes, :tag_attributes, :tag_contents]
      PROPERTIES.each { |prop|
        attr_accessor prop
      }

      def initialize(attributes = {})
        attributes.each { |key, value|
          self.send("#{key}=", value) if PROPERTIES.member? key
        }
      end
      
      def render
        params = {}
        params[:id] = self.tag_id
        params[:class] = self.tag_classes
        params.merge!(self.tag_attributes) unless self.tag_attributes.empty?

        parser = MarkdownUI::Parser.new
        content = parser.render(self.tag_contents)

        erector {
          if self.tag.nil?
            text self.tag_contents
          else
            self.send(self.tag, self.tag_contents, params)
          end
        }
      end
    end
  end
end