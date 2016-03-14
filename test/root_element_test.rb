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

  def test_document_root_element_with_multiple_classes
    markdown = '> %html .no-js .html @lang=""'
    output   = @parser.render(markdown)
    assert_equal '<html class="no-js html" lang=""></html>', output
  end

  def test_document_root_element_with_id
    markdown = '> %html #html @lang=""'
    output   = @parser.render(markdown)
    assert_equal '<html id="html" lang=""></html>', output
  end
  
  def test_document_root_element_with_class_id_and_attribute
    markdown = '> %html .no-js #html @lang="en-US"'
    output   = @parser.render(markdown)
    assert_equal '<html class="no-js" id="html" lang="en-US"></html>', output
  end

  def test_document_root_element_with_boolean_attribute
    markdown = '> %html .no-js @enabled'
    output   = @parser.render(markdown)
    assert_equal '<html class="no-js" enabled="true"></html>', output
  end

  def test_document_root_element_with_content
    markdown = '
> %html .no-js @lang=""
> Content
'
    output   = @parser.render(markdown)
    assert_equal '<html class="no-js" lang="">Content</html>', output
  end


end