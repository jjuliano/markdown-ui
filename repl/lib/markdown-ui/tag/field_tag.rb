module MarkdownUI
  class FieldTag < MarkdownUI::Shared::TagKlass
    def initialize(_content, _klass = nil, __id = nil, _data = nil)
      @content = _content
    end

    def render
      "<field#{_id}#{klass}#{data}>#{@content}</field>"
    end
  end
end
