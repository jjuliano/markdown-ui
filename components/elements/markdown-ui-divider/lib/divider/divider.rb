# coding: UTF-8

module MarkdownUI
  class Divider
    def initialize(element, content)
      @element = element
      @content = content
    end

    def render
      element = @element.strip.downcase
      # Remove 'divider' from element if it exists to avoid duplication
      element = element.gsub(/\s*divider\s*/, '').strip
      klass   = "ui #{element} divider".strip.gsub(/\s+/, ' ')

      "<div#{klass ? " class=\"#{klass}\"" : ""}></div>"
    end
  end
end
