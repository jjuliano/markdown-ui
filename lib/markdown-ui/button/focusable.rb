# coding: UTF-8

module MarkdownUI::Button
  class Focusable
    def initialize(content, klass = nil, _id = nil)
      @klass = klass
      @content = content
      @id = _id
    end

    def render
      content = MarkdownUI::Content::Parser.new(@content).parse
      klass = MarkdownUI::KlassUtil.new("ui #{@klass} button").klass
      _id = if @id
        " id=\"#{@id.split.join('-')}\""
      end

      output = []
      output << "<button"
      output << "#{_id}"
      output << "#{klass}>"
      output << content
      output << "</button>"

      output.join
    end
  end
end
