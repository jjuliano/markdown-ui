module MarkdownUI
  class FormattedTag < MarkdownUI::Shared::TagKlass
    def initialize(_content, _klass = nil, __id = nil, _data = nil)
      @klass   = _klass
      @content = _content
      @data    = _data
      @id      = __id
    end

    def render
      formatted_content = content.to_s.strip
      if formatted_content.empty?
        "<div#{_id}#{klass}#{data}></div>"
      else
        # Check if content already has proper div structure
        if formatted_content.start_with?('<div') && formatted_content.end_with?('</div>')
          # Content is already formatted divs, use minimal indentation
          "<div#{_id}#{klass}#{data}>#{formatted_content}</div>"
        else
          "<div#{_id}#{klass}#{data}>#{formatted_content}</div>"
        end
      end
    end
  end
end