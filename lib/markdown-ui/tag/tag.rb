module MarkdownUI
  class Tag < MarkdownUI::Shared::TagKlass
    def initialize(_tag, _content, _klass = nil, _data = nil)
      @elements = Hash.new(MarkdownUI::StandardTag).merge(
          div:     MarkdownUI::StandardTag,
          label:   MarkdownUI::LabelTag,
          span:    MarkdownUI::SpanTag,
          article: MarkdownUI::ArticleTag,
          section: MarkdownUI::SectionTag,
          header:  MarkdownUI::HeaderTag,
          footer:  MarkdownUI::FooterTag
      )

      @tag      = _tag
      @content  = _content
      @klass    = _klass
      @data     = _data
    end

    def render
      @params = @tag.split

      html { @elements[key].new(content, klass_text, _id, data).render } if content
    end
  end
end
