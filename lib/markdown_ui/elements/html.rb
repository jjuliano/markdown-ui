# coding: UTF-8

module MarkdownUI
  module Elements
    class HTML
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
        puts "id: #{self.tag_id}, classes: #{self.tag_classes}, attributes: #{self.tag_attributes}, contents: #{self.tag_contents}"
        
        tag_params = []
        tag_params << "id=\"#{self.tag_id}\"".strip unless self.tag_id.empty?
        tag_params << "class=\"#{self.tag_classes}\"".strip unless self.tag_classes.empty?
        tag_params << self.tag_attributes unless self.tag_attributes.empty?

        content = []
        content << if tag_params.empty?
        "<html>"
        else
        "<html " + tag_params.join(' ') + ">"
        end
        
        content << if self.tag_contents.empty?
          "</html>"
        else
          self.tag_contents + "</html>"
        end
        
        
        content.join
      end
    end
  end
end