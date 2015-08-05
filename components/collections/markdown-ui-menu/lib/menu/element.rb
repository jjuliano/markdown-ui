module MarkdownUI::Menu
  class Element
    def initialize(element, content, klass = nil)
      @element = element
      @content = content
      @klass = klass
    end

    def render
      element = if @element.is_a? Array
        @element
      else
        @element.split(' ')
      end

      content = @content

      klass = if @klass.nil?
        element.join(' ').strip
      else
        @klass
      end

      mode = OpenStruct.new(
        :item?       => element.grep(/item/i).any?,
        :secondary?  => element.grep(/secondary/i).any?,
        :pagination? => element.grep(/pagination/i).any?,
        :pointing?   => element.grep(/pointing/i).any?,
        :tabular?    => element.grep(/tabular/i).any?,
        :text?       => element.grep(/text/i).any?,
        :vertical?   => element.grep(/vertical/i).any?
      )

      if standard_menu?(mode) && element.size > 1
        MarkdownUI::Menu::Custom.new(element, content, klass).render
      elsif mode.item?
        MarkdownUI::Menu::Custom.new(element, content, klass).render
      elsif mode.secondary?
        MarkdownUI::Menu::Secondary.new(content, klass).render
      elsif mode.pagination?
        MarkdownUI::Menu::Pagination.new(content, klass).render
      elsif mode.pointing?
        MarkdownUI::Menu::Pointing.new(content, klass).render
      elsif mode.tabular?
        MarkdownUI::Menu::Tabular.new(content, klass).render
      elsif mode.text?
        MarkdownUI::Menu::Text.new(content, klass).render
      elsif mode.vertical?
        MarkdownUI::Menu::Vertical.new(content, klass).render
      elsif standard_menu?(mode)
        MarkdownUI::Menu::Standard.new(content, klass).render
      end
    end

    protected

    def standard_menu?(mode)
      !mode.item? && !mode.secondary? && !mode.pagination? && !mode.pointing? && !mode.tabular? && !mode.text? && !mode.vertical?
    end

  end
end
