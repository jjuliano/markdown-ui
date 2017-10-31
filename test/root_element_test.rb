
require_relative 'test_helper'

class TagElementTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_document_tag_element
    markdown = '> %html .no-js @lang=""'
    output   = @parser.render(markdown)
    assert_equal '<html class="no-js" lang=""></html>', output
  end

  def test_document_tag_element_with_multiple_classes
    markdown = '> %html .no-js .html @lang=""'
    output   = @parser.render(markdown)
    assert_equal '<html class="no-js html" lang=""></html>', output
  end

  def test_document_tag_element_with_id
    markdown = '> %html #html @lang=""'
    output   = @parser.render(markdown)
    assert_equal '<html id="html" lang=""></html>', output
  end

  def test_document_tag_element_with_class_id_and_attribute
    markdown = '> %html .no-js #html @lang="en-US"'
    output   = @parser.render(markdown)
    assert_equal '<html class="no-js" id="html" lang="en-US"></html>', output
  end

  def test_document_tag_element_with_boolean_attribute
    markdown = '> %html .no-js @enabled'
    output   = @parser.render(markdown)
    assert_equal '<html class="no-js" enabled="true"></html>', output
  end

  def test_document_tag_element_with_block_content
    markdown = '
> %html .no-js @lang=""
> Block Content
'
    output   = @parser.render(markdown)
    assert_equal '<html class="no-js" lang="">Block Content</html>', output
  end

  def test_document_tag_element_with_inline_content
    markdown = '
> %html .no-js @lang="" \'Inline Content\'
'
    output   = @parser.render(markdown)
    assert_equal '<html class="no-js" lang="">Inline Content</html>', output
  end

  def test_dynamic_tag_element
    markdown = '
> %div .klass #aydee @data-awesome=yes
'
    output   = @parser.render(markdown)
    assert_equal '<div class="klass" data-awesome="yes" id="aydee"></div>', output

    markdown = '
> %span .klass #aydee @data-awesome=yes
'
    output   = @parser.render(markdown)
    assert_equal '<span class="klass" data-awesome="yes" id="aydee"></span>', output
  end
end
