module MarkdownUI
  class Tag
    def initialize(tag, content, klass = nil, data = nil)
      @mode = OpenStruct.new(
        :div?      => !(tag =~ /div/i).nil?,
        :span?     => !(tag =~ /span/i).nil?,
        :article?  => !(tag =~ /article/i).nil?,
        :section?  => !(tag =~ /section/i).nil?,
        :header?   => !(tag =~ /header/i).nil?,
        :footer?   => !(tag =~ /footer/i).nil?
      )
      @tag = tag
      @content = content
      @klass = klass
      @data = data
    end

    def render
      # if @mode.div?
        MarkdownUI::StandardTag.new(@content, @klass, @data).render
      # elsif @mode.span
      #   MarkdownUI::SpanTag.new(@content, @klass).render
      # elsif @mode.article
      #   MarkdownUI::ArticleTag.new(@content, @klass).render
      # elsif @mode.section
      #   MarkdownUI::SectionTag.new(@content, @klass).render
      # elsif @mode.header
      #   MarkdownUI::HeaderTag.new(@content, @klass).render
      # elsif @mode.footer
      #   MarkdownUI::FooterTag.new(@content, @klass).render
      # else
      #   MarkdownUI::CustomTag.new(@tag, @content, @klass).render
      # end
    end

  end
end