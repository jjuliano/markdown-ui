module MarkdownUI
  class StandardTag < MarkdownUI::Shared::TagKlass
    def initialize(_content, _klass = nil, __id = nil, _data = nil)
      @klass   = _klass
      @content = _content
      @data    = _data
      @id      = __id
    end

    def render
      # Generate minified HTML output
      raw_content = @content

      if raw_content && raw_content.include?("")
        # Multi-line content - remove newlines for minification
        content = raw_content.gsub("", "").strip
        "<div#{_id}#{klass}#{data}>#{content}</div>"
      else
        # Single-line content
        content = raw_content || ""
        "<div#{_id}#{klass}#{data}>#{content}</div>"
      end
    end
  end
end
