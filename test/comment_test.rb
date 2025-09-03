# coding: UTF-8
require_relative 'test_helper'

class CommentTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_standard_comment
    markdown = \
'> Comment:
> ![Avatar](avatar.jpg) **Matt**
> How artistic!'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui comment">
  <div class="avatar">
    <img src="avatar.jpg" alt="Avatar" />
  </div>
  <div class="content">
    <div class="author">Matt</div>
    <div class="text">How artistic!</div>
  </div>
</div>
', output
  end

  def test_threaded_comments
    markdown = \
'> Comments:
> > Comment:
> > ![User1](user1.jpg) **John**
> > This is great!
> > > Comment:
> > > ![User2](user2.jpg) **Jane**
> > > I agree!'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui comments">
  <div class="comment">
    <div class="avatar">
      <img src="user1.jpg" alt="User1" />
    </div>
    <div class="content">
      <div class="author">John</div>
      <div class="text">This is great!</div>
      <div class="comments">
        <div class="comment">
          <div class="avatar">
            <img src="user2.jpg" alt="User2" />
          </div>
          <div class="content">
            <div class="author">Jane</div>
            <div class="text">I agree!</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
', output
  end

  def test_minimal_comment
    markdown = \
'> Minimal Comment:
> **Anonymous**
> Simple comment text'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui minimal comment">
  <div class="content">
    <div class="author">Anonymous</div>
    <div class="text">Simple comment text</div>
  </div>
</div>
', output
  end
end