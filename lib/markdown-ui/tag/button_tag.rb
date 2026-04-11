module MarkdownUI
  class ButtonTag < MarkdownUI::Shared::TagKlass
    def initialize(_content, _klass = nil, __id = nil, _data = nil)
      @klass   = _klass
      @content = _content
      @data    = _data
      @id      = __id
    end

    def render
      "<button#{_id}#{klass}#{data}>#{content}</button>"
    end
  end
end
