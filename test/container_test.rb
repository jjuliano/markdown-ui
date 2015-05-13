# coding: UTF-8
require_relative 'test_helper'

class ContainerTest < Redcarpet::TestCase
  def setup
    @parser = Redcarpet::Markdown.new(MarkdownUI::Renderer, quote: true)
  end

  def test_container
    markdown =
<<-EOS
> Container:
> "Lorem Ipsum Dolor"
EOS

    output = @parser.render(markdown)
    assert_equal "<div class=\"ui container\">\n  <p>Lorem Ipsum Dolor</p>\n</div>\n", output
  end

  def test_text_container
    markdown =
<<-EOS
> Text Container:
> # Header
> "Lorem Ipsum Dolor"
EOS

    output = @parser.render(markdown)
    assert_equal "<div class=\"ui text container\">\n  <h1 class=\"ui header\">Header</h1>\n  <p>Lorem Ipsum Dolor</p>\n</div>\n", output
  end

  def test_text_alignment
    markdown =
<<-EOS
> Left Aligned Container:
> Left Aligned
EOS

    output = @parser.render(markdown)
    assert_equal "<div class=\"ui left aligned container\">Left Aligned</div>\n", output

    markdown =
<<-EOS
> Right Aligned Container:
> Right Aligned
EOS

    output = @parser.render(markdown)
    assert_equal "<div class=\"ui right aligned container\">Right Aligned</div>\n", output

    markdown =
<<-EOS
> Center Aligned Container:
> Center Aligned
EOS

    output = @parser.render(markdown)
    assert_equal "<div class=\"ui center aligned container\">Center Aligned</div>\n", output
  end

  def test_custom_container
    markdown =
<<-EOS
> Very Cool Container:
> # Header
> "Lorem Ipsum Dolor"
EOS
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui very cool container\">\n  <h1 class=\"ui header\">Header</h1>\n  <p>Lorem Ipsum Dolor</p>\n</div>\n", output
  end

end