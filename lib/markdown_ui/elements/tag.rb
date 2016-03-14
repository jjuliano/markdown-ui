# coding: UTF-8

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
        params[:id] = self.tag_id unless self.tag_id.empty?
        params[:class] = self.tag_classes unless self.tag_classes.nil?
        params.merge!(self.tag_attributes) unless self.tag_attributes.empty?

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