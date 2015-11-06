module MarkdownUI
  class FocusableButtonTag
    def initialize(content, klass = nil, _id = nil, data = nil)
      @klass = klass
      @content = content
      @data = data
      @id = _id
    end

    def render
      content = @content.strip unless @content.nil?
      klass = MarkdownUI::KlassUtil.new(@klass).klass unless @klass.nil?
      _id = if @id
        " id=\'#{@id.split.join('-')}\'"
      end

      data = if @data
        _data, attribute, value = @data.split(':')
        " data-#{attribute}=\'#{value}\'"
      else
        nil
      end

      "<div#{_id}#{klass}#{data} tabindex=\'0\'>#{content}</div>"
    end
  end
end
