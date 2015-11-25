# coding: UTF-8
require_relative 'test_helper'

class ContainerTest < Redcarpet::TestCase
  def setup
    @parser = Redcarpet::Markdown.new(MarkdownUI::Renderer, quote: true, tables: true, xhtml: true)
  end

  def test_container
    markdown =
        '
> Container:
> "Lorem Ipsum Dolor"
'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui container">
  <p>Lorem Ipsum Dolor</p>
</div>
', output
  end

  def test_text_container
    markdown =
        '
> Text Container:
> # Header
> "Lorem Ipsum Dolor"
'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui text container">
  <h1 class="ui header">Header</h1>
  <p>Lorem Ipsum Dolor</p>
</div>
', output
  end

  def test_text_alignment
    markdown =
        '
> Left Aligned Container:
> Left Aligned
'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui left aligned container">Left Aligned</div>
', output

    markdown =
        '
> Right Aligned Container:
> Right Aligned
'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui right aligned container">Right Aligned</div>
', output

    markdown =
        '
> Center Aligned Container:
> Center Aligned
'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui center aligned container">Center Aligned</div>
', output
  end

  def test_custom_container
    markdown =
        '
> Very Cool Container:
> # Header
> "Lorem Ipsum Dolor"
'
    output   = @parser.render(markdown)
    assert_equal \
'<div class="ui very cool container">
  <h1 class="ui header">Header</h1>
  <p>Lorem Ipsum Dolor</p>
</div>
', output
  end

end
