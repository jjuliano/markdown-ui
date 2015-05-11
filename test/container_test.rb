# coding: UTF-8
require_relative 'test_helper'

class ContainerTest < Redcarpet::TestCase
  def setup
    @parser = Redcarpet::Markdown.new(MarkdownUI::Renderer, quote: true)
  end

  def test_container
    markdown = "> Container:\n> \"Lorem Ipsum Dolor\""
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui container\">\n<p>Lorem Ipsum Dolor</p></div>\n", output
  end

  def test_text_container
    markdown = "> Text Container:\n> # Header\n> \"Lorem Ipsum Dolor\""
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui text container\"><h1 class=\"ui header\">Header</h1><p>Lorem Ipsum Dolor</p></div>\n", output
  end

  def test_text_alignment
    markdown = "> Left Aligned Container:\n> Left Aligned"
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui left aligned container\">\nLeft Aligned</div>\n", output

    markdown = "> Right Aligned Container:\n> Right Aligned"
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui right aligned container\">\nRight Aligned</div>\n", output

    markdown = "> Center Aligned Container:\n> Center Aligned"
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui center aligned container\">\nCenter Aligned</div>\n", output
  end

  def test_custom_container
    markdown = "> Very Cool Container:\n> # Header\n> \"Lorem Ipsum Dolor\""
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui very cool container\"><h1 class=\"ui header\">Header</h1><p>Lorem Ipsum Dolor</p></div>\n", output
  end

end