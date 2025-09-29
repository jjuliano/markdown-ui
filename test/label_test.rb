# coding: UTF-8

require_relative 'test_helper'

class LabelTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_basic_label
    markdown = "__label|New__"
    output = @parser.render(markdown)
    assert_equal "<label class='ui label label'>New</label>", output
  end

  def test_colored_label
    markdown = "__red label|Error__"
    output = @parser.render(markdown)
    assert_equal "<label class='ui red label label'>Error</label>", output
  end

  def test_pointing_label
    markdown = "__pointing label|Important__"
    output = @parser.render(markdown)
    assert_equal "<label class='ui pointing label label'>Important</label>", output
  end

  def test_corner_label
    markdown = "__corner label|x__"
    output = @parser.render(markdown)
    assert_equal "<label class='ui corner label label'>x</label>", output
  end

  def test_tag_label
    markdown = "__label tag|Draft__"
    output = @parser.render(markdown)
    assert_equal "<label>Draft</label>", output
  end

  def test_ribbon_label
    markdown = "__ribbon label|Featured__"
    output = @parser.render(markdown)
    assert_equal "<label class='ui ribbon label label'>Featured</label>", output
  end

  def test_blue_label
    markdown = "__blue label|Info__"
    output = @parser.render(markdown)
    assert_equal "<label class='ui blue label label'>Info</label>", output
  end

  def test_green_label
    markdown = "__green label|Success__"
    output = @parser.render(markdown)
    assert_equal "<label class='ui green label label'>Success</label>", output
  end

  def test_yellow_label
    markdown = "__yellow label|Warning__"
    output = @parser.render(markdown)
    assert_equal "<label class='ui yellow label label'>Warning</label>", output
  end

  def test_orange_label
    markdown = "__orange label|Alert__"
    output = @parser.render(markdown)
    assert_equal "<label class='ui orange label label'>Alert</label>", output
  end

  def test_purple_label
    markdown = "__purple label|Special__"
    output = @parser.render(markdown)
    assert_equal "<label class='ui purple label label'>Special</label>", output
  end

  def test_pink_label
    markdown = "__pink label|Love__"
    output = @parser.render(markdown)
    assert_equal "<label class='ui pink label label'>Love</label>", output
  end

  def test_teal_label
    markdown = "__teal label|Cool__"
    output = @parser.render(markdown)
    assert_equal "<label class='ui teal label label'>Cool</label>", output
  end

  def test_circular_label
    markdown = "__circular label|5__"
    output = @parser.render(markdown)
    assert_equal "<label class='ui circular label label'>5</label>", output
  end

  def test_empty_circular_label
    markdown = "__empty circular label|__"
    output = @parser.render(markdown)
    assert_equal "<label class='ui empty circular label label'></label>", output
  end

  def test_basic_label_with_icon
    markdown = "__label|mail New Message__"
    output = @parser.render(markdown)
    assert_equal "<label class='ui label label'>mail New Message</label>", output
  end

  def test_image_label
    markdown = "__image label|Profile Picture John__"
    output = @parser.render(markdown)
    assert_equal "<label class='ui image label label'>Profile Picture John</label>", output
  end

  def test_right_pointing_label
    markdown = "__right pointing label|Next__"
    output = @parser.render(markdown)
    assert_equal "<label class='ui right pointing label label'>Next</label>", output
  end

  def test_left_pointing_label
    markdown = "__left pointing label|Back__"
    output = @parser.render(markdown)
    assert_equal "<label class='ui left pointing label label'>Back</label>", output
  end

  def test_basic_pointing_label
    markdown = "__basic pointing label|Simple__"
    output = @parser.render(markdown)
    assert_equal "<label class='ui basic pointing label label'>Simple</label>", output
  end

  def test_floating_label
    markdown = "__floating label|2__"
    output = @parser.render(markdown)
    assert_equal "<label class='ui floating label label'>2</label>", output
  end

  def test_right_corner_label
    markdown = "__right corner label|New__"
    output = @parser.render(markdown)
    assert_equal "<label class='ui right corner label label'>New</label>", output
  end

  def test_left_corner_label
    markdown = "__left corner label|Sale__"
    output = @parser.render(markdown)
    assert_equal "<label class='ui left corner label label'>Sale</label>", output
  end

  def test_right_ribbon_label
    markdown = "__right ribbon label|Popular__"
    output = @parser.render(markdown)
    assert_equal "<label class='ui right ribbon label label'>Popular</label>", output
  end

  def test_attached_label
    markdown = "__attached label|Top__"
    output = @parser.render(markdown)
    assert_equal "<label class='ui attached label label'>Top</label>", output
  end

  def test_bottom_attached_label
    markdown = "__bottom attached label|Bottom__"
    output = @parser.render(markdown)
    assert_equal "<label class='ui bottom attached label label'>Bottom</label>", output
  end

  def test_horizontal_label
    markdown = "__horizontal label|Price: $10__"
    output = @parser.render(markdown)
    assert_equal "<label class='ui horizontal label label'>Price: $10</label>", output
  end
end