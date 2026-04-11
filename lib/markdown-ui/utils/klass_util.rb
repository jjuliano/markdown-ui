module MarkdownUI
  class KlassUtil
    def initialize(_text)
      @text = sanitize(_text)
    end

    def klass
      " class=\'#{text}\'"
    end

    def text
      @text.join(' ').strip
    end

    protected

    def sanitize(_text)
      _text.downcase.split(' ').uniq
    end
  end
end
