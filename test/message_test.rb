# coding: UTF-8
require_relative 'test_helper'

class MessageTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_message
    markdown =
        '
__Message|Header:Changes in Service,Text:"We just updated our privacy policy here to better service our customers. We recommend reviewing the changes."__
'

    output = @parser.render(markdown)
    assert_equal "<div class='ui message'>\n  <div class='ui header'>Changes in Service</div>\n  <p>We just updated our privacy policy here to better service our customers. We recommend reviewing the changes.</p>\n</div>", output
  end

  def test_message_alternative
    markdown =
        '
> Message:
> __Header|Changes in Service__
> "We just updated our privacy policy here to better service our customers. We recommend reviewing the changes."
'

    output = @parser.render(markdown)
    assert_equal "<div class='ui message'>\n  <header>\n    <div class='ui header'>Changes in Service</div>\n  </header>\n  <p>We just updated our privacy policy here to better service our customers. We recommend reviewing the changes.</p>\n</div>", output
  end

  def test_list_message
    markdown =
        '
__List Message|Header: New Site Features, List: You can now have cover images on blog pages;Drafts will now auto-save while writing__
'

    output = @parser.render(markdown)
    assert_equal "<div class='ui message'>\n  <div class='ui header'>New Site Features</div>\n  <ul class='ui list'>\n    <li>You can now have cover images on blog pages</li>\n    <li>Drafts will now auto-save while writing</li>\n  </ul>\n</div>", output
  end

  def test_list_message_alternative_ordered
    markdown =
        '
> List Message:
> __Header|New Site Features__
>
> 1. You can now have cover images on blog pages
> 1. Drafts will now auto-save while writing
'

    output = @parser.render(markdown)
    assert_equal "<div class='ui message'>\n  <header>\n    <div class='ui header'>New Site Features</div>\n  </header>\n  <ol class='ui ordered list'>\n    <li>You can now have cover images on blog pages</li>\n    <li>Drafts will now auto-save while writing</li>\n  </ol>\n</div>", output
  end

  def test_list_message_alternative_unordered
    markdown =
        '
> List Message:
> __Header|New Site Features__
>
> * You can now have cover images on blog pages
> * Drafts will now auto-save while writing
'

    output = @parser.render(markdown)
    assert_equal "<div class='ui message'>\n  <header>\n    <div class='ui header'>New Site Features</div>\n  </header>\n  <ul class='ui unordered list'>\n    <li>You can now have cover images on blog pages</li>\n    <li>Drafts will now auto-save while writing</li>\n  </ul>\n</div>", output
  end
end
