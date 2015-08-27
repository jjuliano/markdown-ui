module MarkdownUI
  class InputTag
    def initialize(content, klass = nil, _id = nil, data = nil)
      @klass = klass
      @content = content
      @data = data
      @id = _id
    end

    def render
      content = if @content
        " type=\"#{@content.strip.downcase}\""
      else
        nil
      end

      klass = MarkdownUI::KlassUtil.new(@klass).klass unless @klass.nil?

      _id = if @id
        " placeholder=\"#{@id.capitalize}\""
      end

      data = if @data
        _data, attribute, value = @data.split(':')
        " data-#{attribute}=\"#{value}\""
      else
        nil
      end


      "<input#{content}#{_id}#{klass}#{data} />"
    end
  end
end
