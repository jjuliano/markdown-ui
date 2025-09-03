module MarkdownUI
  class SegmentTag < MarkdownUI::Shared::TagKlass
    def initialize(_content, _klass = nil, __id = nil, _data = nil)
      @klass   = _klass
      @content = _content
      @data    = _data
      @id      = __id
    end

    def render
      # Minified HTML output
      formatted_content = content.to_s.strip
      if formatted_content.empty?
        "<section#{_id}#{klass}#{data}></section>"
      else
        "<section#{_id}#{klass}#{data}>#{formatted_content}</section>"
      end
    end
  end
end