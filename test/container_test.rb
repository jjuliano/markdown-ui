# coding: UTF-8
require_relative 'test_helper'

class ContainerTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_container
    markdown =
        '
> Container:
> "Lorem Ipsum Dolor"
'

    output = @parser.render(markdown)
    assert_equal "<article class='ui container'>\n  <p>Lorem Ipsum Dolor</p>\n</article>", output
  end

  def test_text_container
    markdown =
        '
> Text Container:
> # Header
> "Lorem Ipsum Dolor"
'

    output = @parser.render(markdown)
    assert_equal "<article class='ui text container'>\n  <header>\n    <h1 class='ui header'>Header</h1>\n  </header>\n  <p>Lorem Ipsum Dolor</p>\n</article>", output
  end

  def test_text_alignment
    markdown =
        '
> Left Aligned Container:
> Left Aligned
'

    output = @parser.render(markdown)
    assert_equal "<article class='ui left aligned container'>Left Aligned</article>", output

    markdown =
        '
> Right Aligned Container:
> Right Aligned
'

    output = @parser.render(markdown)
    assert_equal "<article class='ui right aligned container'>Right Aligned</article>", output

    markdown =
        '
> Center Aligned Container:
> Center Aligned
'

    output = @parser.render(markdown)
    assert_equal "<article class='ui center aligned container'>Center Aligned</article>", output
  end

  def test_custom_container
    markdown =
        '
> Very Cool Container:
> # Header
> "Lorem Ipsum Dolor"
'
    output   = @parser.render(markdown)
    assert_equal "<article class='ui very cool container'>\n  <header>\n    <h1 class='ui header'>Header</h1>\n  </header>\n  <p>Lorem Ipsum Dolor</p>\n</article>", output
  end

end
