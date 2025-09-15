module MarkdownUI
  class SectionTag < MarkdownUI::Shared::TagKlass
    def initialize(_content, _klass = nil, __id = nil, _data = nil)
      @klass   = _klass
      @content = _content
      @data    = _data
      @id      = __id
    end

    def render
      "<section#{_id}#{klass}#{data}>#{content}</section>"
    end
  end
end
