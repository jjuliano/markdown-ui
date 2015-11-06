module MarkdownUI
  class KlassUtil
    def initialize(text)
      @text = text.downcase.split(' ').uniq
    end

    def klass
      " class=\'#{@text.join(' ').strip}\'"
    end
  end
end
