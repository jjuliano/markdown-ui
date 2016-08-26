module MarkdownUI
  class MenuTag < MarkdownUI::Shared::TagKlass
    def initialize(_content, _klass = nil, __id = nil, _data = nil)
      @content = _content
    end

    def render
      "<menu#{_id}#{klass}#{data}>#{@content}</menu>"
    end
  end
end
