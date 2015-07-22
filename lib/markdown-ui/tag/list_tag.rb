module MarkdownUI
  class ListTag
    def initialize(content, klass = nil, type = nil, data = nil)
      @klass = klass
      @content = content
      @type = type
      @data = data
    end

    def render
      content = @content.split(';')
      klass = MarkdownUI::KlassUtil.new(@klass).klass

      data = if @data
        _data, attribute, value = @data.split(':')
        " data-#{attribute}=\"#{value}\""
      else
        nil
      end

      list = ""
      if !content.grep(/^\<li\>.*/).empty?
        list = content.join
      else
        content.each do |c|
          list += "<li>#{c}</li>"
        end
      end

      @type = :unordered if @type.nil?

      case @type
      when :ordered
        "<ol#{klass}#{data}>#{list}</ol>"
      when :unordered
        "<ul#{klass}#{data}>#{list}</ul>"
      end
    end
  end
end
