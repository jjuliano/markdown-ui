module MarkdownUI
  class ItemTag
    def initialize(content, klass = nil, link = nil)
      @klass = klass
      @content = content
      @link = link
    end

    def render
      content, @data = @content.split(";")
      klass = MarkdownUI::KlassUtil.new(@klass).klass
      link = " href=\"#{@link.strip}\""

      data = if @data
        _data, attribute, value = @data.split(":")
        " data-#{attribute}=\"#{value}\""
      else
        nil
      end

      "<a#{klass}#{data}#{link}>#{content}</a>"
    end
  end
end