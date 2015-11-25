# coding: UTF-8
require_relative 'test_helper'

class FlagTest < Redcarpet::TestCase
  def setup
    @parser = Redcarpet::Markdown.new(MarkdownUI::Renderer, quote: true, tables: true, xhtml: true)
  end

  def test_flag
    markdown =
        '
_AE Flag_
_France Flag_
_Myanmar Flag_
'

    output = @parser.render(markdown)
    assert_equal \
"<i class=\'ae flag\'></i>\n<i class=\'france flag\'></i>\n<i class=\'myanmar flag\'></i>", output
  end

end
