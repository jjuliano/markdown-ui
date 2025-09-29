# coding: UTF-8

require_relative 'test_helper'

class FormTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_basic_form
    markdown = "__form|Text:First Name, Text: Last Name, Checkbox: I agree to the Terms and Conditions, Button: Submit__"
    output = @parser.render(markdown)
    assert_equal "<form class='ui form'><div class='field'><label>First Name</label><input type='text' name='first_name' placeholder='First Name'/></div><div class='field'><label>Last Name</label><input type='text' name='last_name' placeholder='Last Name'/></div><div class='field'><div class='ui checkbox'><input type='checkbox' tabindex='0' class='hidden' name='terms_and_conditions' /><label>I agree to the Terms and Conditions</label></div></div><div class='field'><button class='ui button'>Submit</button></div></form>", output
  end

  def test_loading_form
    markdown = "__loading form|Text:First Name, Text: Last Name, Checkbox: I agree to the Terms and Conditions, Button: Submit__"
    output = @parser.render(markdown)
    assert_equal "<form class='ui loading form'><div class='field'><label>First Name</label><input type='text' name='first_name' placeholder='First Name'/></div><div class='field'><label>Last Name</label><input type='text' name='last_name' placeholder='Last Name'/></div><div class='field'><div class='ui checkbox'><input type='checkbox' tabindex='0' class='hidden' name='terms_and_conditions' /><label>I agree to the Terms and Conditions</label></div></div><div class='field'><button class='ui button'>Submit</button></div></form>", output
  end

  def test_success_form
    markdown = "__success form|Text:First Name, Text: Last Name, Checkbox: I agree to the Terms and Conditions, Button: Submit__"
    output = @parser.render(markdown)
    assert_equal "<form class='ui success form'><div class='field'><label>First Name</label><input type='text' name='first_name' placeholder='First Name'/></div><div class='field'><label>Last Name</label><input type='text' name='last_name' placeholder='Last Name'/></div><div class='field'><div class='ui checkbox'><input type='checkbox' tabindex='0' class='hidden' name='terms_and_conditions' /><label>I agree to the Terms and Conditions</label></div></div><div class='field'><button class='ui button'>Submit</button></div></form>", output
  end

  def test_error_form
    markdown = "__error form|Text:First Name, Text: Last Name, Checkbox: I agree to the Terms and Conditions, Button: Submit__"
    output = @parser.render(markdown)
    assert_equal "<form class='ui error form'><div class='field'><label>First Name</label><input type='text' name='first_name' placeholder='First Name'/></div><div class='field'><label>Last Name</label><input type='text' name='last_name' placeholder='Last Name'/></div><div class='field'><div class='ui checkbox'><input type='checkbox' tabindex='0' class='hidden' name='terms_and_conditions' /><label>I agree to the Terms and Conditions</label></div></div><div class='field'><button class='ui button'>Submit</button></div></form>", output
  end

  def test_warning_form
    markdown = "__warning form|Text:First Name, Text: Last Name, Checkbox: I agree to the Terms and Conditions, Button: Submit__"
    output = @parser.render(markdown)
    assert_equal "<form class='ui warning form'><div class='field'><label>First Name</label><input type='text' name='first_name' placeholder='First Name'/></div><div class='field'><label>Last Name</label><input type='text' name='last_name' placeholder='Last Name'/></div><div class='field'><div class='ui checkbox'><input type='checkbox' tabindex='0' class='hidden' name='terms_and_conditions' /><label>I agree to the Terms and Conditions</label></div></div><div class='field'><button class='ui button'>Submit</button></div></form>", output
  end

  def test_inverted_form
    markdown = "__inverted form|Dark theme form |Text:First Name, Text: Last Name, Checkbox: I agree to the Terms and Conditions, Button: Submit__"
    output = @parser.render(markdown)
    assert_equal "<form class='ui inverted form'><div class='field'><label>First Name</label><input type='text' name='first_name' placeholder='First Name'/></div><div class='field'><label>Last Name</label><input type='text' name='last_name' placeholder='Last Name'/></div><div class='field'><div class='ui checkbox'><input type='checkbox' tabindex='0' class='hidden' name='terms_and_conditions' /><label>I agree to the Terms and Conditions</label></div></div><div class='field'><button class='ui button'>Submit</button></div></form>", output
  end

  def test_size_forms
    markdown = "__small form|Small form |Text:First Name, Text: Last Name, Checkbox: I agree to the Terms and Conditions, Button: Submit__"
    output = @parser.render(markdown)
    assert_equal "<form class='ui small form'><div class='field'><label>First Name</label><input type='text' name='first_name' placeholder='First Name'/></div><div class='field'><label>Last Name</label><input type='text' name='last_name' placeholder='Last Name'/></div><div class='field'><div class='ui checkbox'><input type='checkbox' tabindex='0' class='hidden' name='terms_and_conditions' /><label>I agree to the Terms and Conditions</label></div></div><div class='field'><button class='ui button'>Submit</button></div></form>", output
  end

  def test_large_form
    markdown = "__large form|Large form |Text:First Name, Text: Last Name, Checkbox: I agree to the Terms and Conditions, Button: Submit__"
    output = @parser.render(markdown)
    assert_equal "<form class='ui large form'><div class='field'><label>First Name</label><input type='text' name='first_name' placeholder='First Name'/></div><div class='field'><label>Last Name</label><input type='text' name='last_name' placeholder='Last Name'/></div><div class='field'><div class='ui checkbox'><input type='checkbox' tabindex='0' class='hidden' name='terms_and_conditions' /><label>I agree to the Terms and Conditions</label></div></div><div class='field'><button class='ui button'>Submit</button></div></form>", output
  end
end