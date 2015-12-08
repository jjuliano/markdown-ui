module MarkdownUI
  class ScriptTag < MarkdownUI::Shared::TagKlass
    def initialize(_content)
      @content = _content
    end

    def render
      "<script>#{@content}</script>"
    end
  end
end
