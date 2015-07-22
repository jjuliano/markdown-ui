# coding: UTF-8
require_relative 'test_helper'

class MessageTest < Redcarpet::TestCase
  def setup
    @parser = Redcarpet::Markdown.new(MarkdownUI::Renderer, quote: true)
  end

  def test_message
    markdown =
'
__Message|Header:Changes in Service,Text:"We just updated our privacy policy here to better service our customers. We recommend reviewing the changes."__
'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui message">
  <div class="header">Changes in Service</div>
  <p>We just updated our privacy policy here to better service our customers. We recommend reviewing the changes.</p>
</div>
', output
  end

  def test_message_alternative
    markdown =
'
> Message:
> __Header|Changes in Service__
> "We just updated our privacy policy here to better service our customers. We recommend reviewing the changes."
'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui message">
  <div class="ui header">Changes in Service</div>
  <p>We just updated our privacy policy here to better service our customers. We recommend reviewing the changes.</p>
</div>
', output
  end

  def test_list_message
    markdown =
'
__List Message|Header: New Site Features, List: You can now have cover images on blog pages;Drafts will now auto-save while writing__
'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui message">
  <div class="header">New Site Features</div>
  <ul class="list">
    <li>You can now have cover images on blog pages</li>
    <li>Drafts will now auto-save while writing</li>
  </ul>
</div>
', output
  end

  def test_list_message_alternative
    markdown =
'
> List Message:
> __Header|New Site Features__
>
> * You can now have cover images on blog pages
> * Drafts will now auto-save while writing
'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui message">
  <div class="ui header">New Site Features</div>
  <ul class="ui list">
    <li>You can now have cover images on blog pages</li>
    <li>Drafts will now auto-save while writing</li>
  </ul>
</div>
', output
  end
end
