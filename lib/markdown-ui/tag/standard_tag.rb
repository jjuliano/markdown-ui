module MarkdownUI
  class StandardTag
    def initialize(content, klass = nil, data = nil)
      @klass = klass
      @content = content
      @data = data
    end

    def render
      content = @content.strip unless @content.nil?
      klass = MarkdownUI::KlassUtil.new(@klass).klass

      data = if @data
        _data, attribute, value = @data.split(":")
        " data-#{attribute}=\"#{value}\""
      else
        nil
      end

      "<div#{klass}#{data}>#{content}</div>"
    end
  end
end