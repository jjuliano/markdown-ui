module MarkdownUI
  class FooterTag < MarkdownUI::Shared::TagKlass
    def initialize(_content, _klass = nil, __id = nil, _data = nil)
      @klass   = _klass
      @content = _content
      @data    = _data
      @id      = __id
    end

    def render
      "<footer#{_id}#{klass}#{data}>#{content}</footer>"
    end
  end
end
