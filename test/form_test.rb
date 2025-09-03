# coding: UTF-8
require_relative 'test_helper'

class FormTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_standard_form
    markdown = \
'> Form:
> __Field|First Name__
> __Input|Enter first name__
> __Button|Submit|primary__'

    output = @parser.parse(markdown)
    assert_equal \
'<form class="ui form">
  <div class="field">
    <label>First Name</label>
    <div class="ui input">
      <input type="text" placeholder="Enter first name" />
    </div>
  </div>
  <button class="ui primary button">Submit</button>
</form>', output
  end

  def test_form_with_class_and_id
    markdown = \
'> .contact-form#registration-form Form:
> __Field|Email__
> __Input|Enter your email__
> __.submit-btn#submit-btn Button|Register__'

    output = @parser.parse(markdown)
    assert_equal \
'<form class="ui form contact-form" id="registration-form">
  <div class="field">
    <label>Email</label>
    <div class="ui input">
      <input type="text" placeholder="Enter your email" />
    </div>
  </div>
  <button class="ui button submit-btn" id="submit-btn">Register</button>
</form>', output
  end

  def test_form_with_grouped_fields
    markdown = \
'> Form:
> > Fields:
> > __Field|First Name__
> > __Input|First name__
> > __Field|Last Name__
> > __Input|Last name__'

    output = @parser.parse(markdown)
    assert_equal \
'<form class="ui form">
  <div class="fields">
    <div class="field">
      <label>First Name</label>
      <div class="ui input">
        <input type="text" placeholder="First name" />
      </div>
    </div>
    <div class="field">
      <label>Last Name</label>
      <div class="ui input">
        <input type="text" placeholder="Last name" />
      </div>
    </div>
  </div>
</form>
', output
  end

  def test_loading_form
    markdown = \
'> Loading Form:
> __Field|Email__
> __Input|Email address__'

    output = @parser.parse(markdown)
    assert_equal \
'<form class="ui loading form">
  <div class="field">
    <label>Email</label>
    <div class="ui input">
      <input type="text" placeholder="Email address" />
    </div>
  </div>
</form>
', output
  end

  def test_success_form
    markdown = \
'> Success Form:
> __Message|Success|success|Form submitted successfully!__
> __Field|Email__
> __Input|Email address__'

    output = @parser.parse(markdown)
    assert_equal \
'<form class="ui success form">
  <div class="ui success message">
    <div class="header">Success</div>
    <p>Form submitted successfully!</p>
  </div>
  <div class="field">
    <label>Email</label>
    <div class="ui input">
      <input type="text" placeholder="Email address" />
    </div>
  </div>
</form>
', output
  end

  def test_error_form
    markdown = \
'> Error Form:
> __Message|Error|error|Please correct the errors below__
> __Field|Email|error__
> __Input|Email address|error__'

    output = @parser.parse(markdown)
    assert_equal \
'<form class="ui error form">
  <div class="ui error message">
    <div class="header">Error</div>
    <p>Please correct the errors below</p>
  </div>
  <div class="error field">
    <label>Email</label>
    <div class="ui error input">
      <input type="text" placeholder="Email address" />
    </div>
  </div>
</form>
', output
  end

  def test_inverted_form
    markdown = \
'> Inverted Form:
> __Field|Email__
> __Input|Email address|inverted__'

    output = @parser.parse(markdown)
    assert_equal \
'<form class="ui inverted form">
  <div class="field">
    <label>Email</label>
    <div class="ui inverted input">
      <input type="text" placeholder="Email address" />
    </div>
  </div>
</form>
', output
  end

  def test_equal_width_form
    markdown = \
'> Equal Width Form:
> > Fields:
> > __Field|First Name__
> > __Input|First name__
> > __Field|Last Name__
> > __Input|Last name__'

    output = @parser.parse(markdown)
    assert_equal \
'<form class="ui equal width form">
  <div class="fields">
    <div class="field">
      <label>First Name</label>
      <div class="ui input">
        <input type="text" placeholder="First name" />
      </div>
    </div>
    <div class="field">
      <label>Last Name</label>
      <div class="ui input">
        <input type="text" placeholder="Last name" />
      </div>
    </div>
  </div>
</form>
', output
  end

  def test_sized_form
    markdown = \
'> Mini Form:
> __Field|Email__
> __Input|Email address__'

    output = @parser.parse(markdown)
    assert_equal \
'<form class="ui mini form">
  <div class="field">
    <label>Email</label>
    <div class="ui input">
      <input type="text" placeholder="Email address" />
    </div>
  </div>
</form>
', output
  end
end