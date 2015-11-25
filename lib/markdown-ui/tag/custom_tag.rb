# coding: UTF-8
module MarkdownUI
  class CustomTag < MarkdownUI::Shared::TagKlass
    def initialize(_tag, _content, _klass = nil)
      @tag     = _tag
      @klass   = _klass
      @content = _content
    end

    def render
      output = []
      output << "<#{tag}"
      output << "#{klass}>"
      output << content
      output << "</#{tag}>"

      output.join(' ')
    end

    protected

    def tag
      @tag.downcase.strip
    end
  end
end
