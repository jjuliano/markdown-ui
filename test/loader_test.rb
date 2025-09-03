# coding: UTF-8
require_relative 'test_helper'

class LoaderTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_standard_loader
    markdown = '__Loader__'
    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui loader"></div>
', output
  end

  def test_text_loader
    markdown = '__Loader|Loading content__'
    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui text loader">Loading content</div>
', output
  end

  def test_active_loader
    markdown = '__Loader|Loading...|active__'
    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui active text loader">Loading...</div>
', output
  end

  def test_disabled_loader
    markdown = '__Loader|Disabled|disabled__'
    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui disabled text loader">Disabled</div>
', output
  end

  def test_inline_loader
    markdown = '__Loader|Loading|inline__'
    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui inline loader">Loading</div>
', output
  end

  def test_centered_inline_loader
    markdown = '__Loader|Loading|centered inline__'
    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui centered inline loader">Loading</div>
', output
  end

  def test_sized_loaders
    markdown_mini = '__Loader|Mini|mini__'
    output_mini = @parser.parse(markdown_mini)
    assert_equal \
'<div class="ui mini text loader">Mini</div>
', output_mini

    markdown_large = '__Loader|Large|large__'
    output_large = @parser.parse(markdown_large)
    assert_equal \
'<div class="ui large text loader">Large</div>
', output_large
  end

  def test_inverted_loader
    markdown = '__Loader|Loading...|inverted__'
    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui inverted text loader">Loading...</div>
', output
  end

  def test_loader_with_segment
    markdown = \
'> Loading Segment:
> __Loader|Processing...__
> Content is loading.'

    output = @parser.parse(markdown)
    assert_equal \
'<section class="ui loading segment">
  <div class="ui text loader">Processing...</div>
  <p>Content is loading.</p>
</section>
', output
  end

  def test_dimmed_loader
    markdown = '__Loader|Processing|dimmer__'
    output = @parser.parse(markdown)
    assert_equal \
'<div class="ui dimmer">
  <div class="ui text loader">Processing</div>
</div>
', output
  end
end