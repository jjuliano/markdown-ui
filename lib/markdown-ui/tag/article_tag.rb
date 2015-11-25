module MarkdownUI
  class ArticleTag < MarkdownUI::Shared::TagKlass
    def initialize(_content, _klass = nil, __id = nil, _data = nil)
      @klass   = _klass
      @content = _content
      @data    = _data
      @id      = __id
    end

    def render
      "<article#{_id}#{klass}#{data}>#{content}</article>"
    end
  end
end
