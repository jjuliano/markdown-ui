# coding: UTF-8
require_relative 'test_helper'

class ButtonTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_document_root_element
    markdown = '> %html .no-js @lang=""'
    output   = @parser.render(markdown)
    assert_equal '<html class="no-js" lang=""></html>', output
  end

  def test_document_root_element_with_content
    markdown = \
'
> %html .no-js @lang=""
> "This is a paragraph"
'
    output   = @parser.render(markdown)
    assert_equal '<html class="no-js" lang=""><p>This is a paragraph</p></html>', output
  end

end