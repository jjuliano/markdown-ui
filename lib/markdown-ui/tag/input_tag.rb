require_relative 'tag_klass'

module MarkdownUI
  class InputTag < TagKlass
    def initialize(_content, _klass = nil, __id = nil, _data = nil)
      @klass = _klass
      @content = _content
      @data = _data
      @id = __id
    end

    def render
      "<input#{input_content}#{_input_id}#{klass}#{data} />"
    end
  end
end
