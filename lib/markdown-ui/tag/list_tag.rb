require_relative "tag_klass"

module MarkdownUI
  class ListTag < TagKlass
    def initialize(_content, _klass = nil, _type = nil, _data = nil)
      @klass = _klass
      @content = _content
      @type = _type
      @data = _data
    end

    def render
      content = @content.split(';')

      @type = :unordered if @type.nil?

      case @type
      when :ordered
        "<ol#{klass}#{data}>#{list(content)}</ol>"
      when :unordered
        "<ul#{klass}#{data}>#{list(content)}</ul>"
      end
    end

    protected

    def list(content)
      list = ''
      if !content.grep(/^\<li\>.*/).empty?
        list = content.join
      else
        content.each do |c|
          list += "<li>#{c}</li>"
        end
      end
      list
    end
  end
end
