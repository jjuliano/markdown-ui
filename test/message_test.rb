# coding: UTF-8
require_relative 'test_helper'

class MessageTest < Redcarpet::TestCase
  def setup
    @parser = Redcarpet::Markdown.new(MarkdownUI::Renderer, quote: true)
  end

  def test_message
    markdown =
<<-EOS
__Message|Header:Changes in Service,Text:"We just updated our privacy policy here to better service our customers. We recommend reviewing the changes."__
EOS

    output = @parser.render(markdown)
    assert_equal "<div class=\"ui message\">\n  <div class=\"header\">Changes in Service</div>\n  <p>We just updated our privacy policy here to better service our customers. We recommend reviewing the changes.</p>\n</div>\n", output
  end

  def test_message_alternative
    markdown =
<<-EOS
> Message:
> __Header|Changes in Service__
> "We just updated our privacy policy here to better service our customers. We recommend reviewing the changes."
EOS

    output = @parser.render(markdown)
    assert_equal "<div class=\"ui message\">\n  <div class=\"ui header\">Changes in Service</div>\n  <p>We just updated our privacy policy here to better service our customers. We recommend reviewing the changes.</p>\n</div>\n", output
  end

  def test_list_message
    markdown =
<<-EOS
__List Message|Header: New Site Features, List: You can now have cover images on blog pages;Drafts will now auto-save while writing__
EOS

    output = @parser.render(markdown)
    assert_equal "<div class=\"ui message\">\n  <div class=\"header\">New Site Features</div>\n  <ul class=\"list\">\n    <li>You can now have cover images on blog pages</li>\n    <li>Drafts will now auto-save while writing</li>\n  </ul>\n</div>\n", output
  end

  def test_list_message_alternative
    markdown =
<<-EOS
> List Message:
> __Header|New Site Features__
>
> * You can now have cover images on blog pages
> * Drafts will now auto-save while writing
EOS

    output = @parser.render(markdown)
    assert_equal "<div class=\"ui message\">\n  <div class=\"ui header\">New Site Features</div>\n  <ul class=\"ui list\">\n    <li>You can now have cover images on blog pages</li>\n    <li>Drafts will now auto-save while writing</li>\n  </ul>\n</div>\n", output
  end
end
