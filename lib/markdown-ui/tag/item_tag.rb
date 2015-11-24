require_relative 'tag_klass'

module MarkdownUI
  class ItemTag < TagKlass
    def initialize(_content, _klass = nil, _link = nil)
      @klass = _klass
      @content = _content
      @link = _link
    end

    def render
      content, @data = @content.split(';')
      link = " href=\'#{@link.strip}\'" if @link

      "<a#{klass}#{data}#{link}>#{content}</a>"
    end
  end
end
