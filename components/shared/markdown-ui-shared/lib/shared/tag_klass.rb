module MarkdownUI
  module Shared
    class TagKlass
      def content
        if @content
          _content = MarkdownUI::Content::Parser.new(@content).parse
          _content.strip
        end
      end

      def element
        if @element
          (@element.is_a? Array) ? @element.join(' ').strip : @element.strip
        end
      end

      def html
        if block_given?
          HTMLFormatter.new(yield).to_html
        end
      end

      def klass
        MarkdownUI::KlassUtil.new(@klass).klass unless @klass.nil?
      end

      def klass_text
        MarkdownUI::KlassUtil.new(@klass).text unless @klass.nil?
      end

      def _id
        if @id
          " id=\'#{@id.split.join('-')}\'"
        end
      end

      def data
        if @data
          if @data =~ /\:/
            _data, attribute, value = @data.split(':')
            " data-#{attribute}=\'#{value}\'"
          else
            @data
          end
        else
          nil
        end
      end

      def _input_id
        if @id
          " placeholder=\'#{@id.capitalize}\'"
        end
      end

      def input_content
        if @content
          " type=\'#{@content.strip.downcase}\'"
        else
          nil
        end
      end

      def regexp
        Regexp.new (@params.collect { |u| u.downcase }).join('|'), "i"
      end

      def key
        _keys = keys.grep(regexp)
        _keys.size > 2 ? _keys.join(' ') : _keys.first
      end

      def keys
        @elements.keys
      end
    end
  end
end
