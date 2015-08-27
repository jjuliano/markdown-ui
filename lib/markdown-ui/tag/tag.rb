module MarkdownUI
  class Tag
    def initialize(tag, content, klass = nil, data = nil)
      @mode = OpenStruct.new(
        :div?      => !(tag =~ /div/i).nil?,
        :label?    => !(tag =~ /label/i).nil?,
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
      if @mode.div?
        MarkdownUI::StandardTag.new(@content, @klass, nil, @data).render
      elsif @mode.label?
        MarkdownUI::LabelTag.new(@content, @klass, nil, @data).render
      end
    end

  end
end
