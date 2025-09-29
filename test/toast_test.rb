# coding: UTF-8

require_relative 'test_helper'

class ToastTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_basic_toast
    markdown = "__toast|Success! Your action was completed.__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui toast toast'>Success! Your action was completed.</div>", output
  end

  def test_success_toast
    markdown = "__success toast|Operation completed successfully.__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui success toast toast'>Operation completed successfully.</div>", output
  end

  def test_error_toast
    markdown = "__error toast|Something went wrong.__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui error toast toast'>Something went wrong.</div>", output
  end

  def test_warning_toast
    markdown = "__warning toast|Please check your input.__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui warning toast toast'>Please check your input.</div>", output
  end

  def test_info_toast
    markdown = "__info toast|New features available.__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui info toast toast'>New features available.</div>", output
  end

  def test_floating_toast
    markdown = "__floating toast|Message floating above content.__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui floating toast toast'>Message floating above content.</div>", output
  end

  def test_colored_toast
    markdown = "__blue toast|Information message.__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui blue toast toast'>Information message.</div>", output
  end

  def test_green_toast
    markdown = "__green toast|Success notification.__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui green toast toast'>Success notification.</div>", output
  end

  def test_yellow_toast
    markdown = "__yellow toast|Warning notification.__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui yellow toast toast'>Warning notification.</div>", output
  end

  def test_red_toast
    markdown = "__red toast|Error notification.__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui red toast toast'>Error notification.</div>", output
  end

  def test_orange_toast
    markdown = "__orange toast|Alert notification.__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui orange toast toast'>Alert notification.</div>", output
  end

  def test_purple_toast
    markdown = "__purple toast|Special notification.__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui purple toast toast'>Special notification.</div>", output
  end

  def test_pink_toast
    markdown = "__pink toast|Love notification.__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui pink toast toast'>Love notification.</div>", output
  end

  def test_teal_toast
    markdown = "__teal toast|Cool notification.__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui teal toast toast'>Cool notification.</div>", output
  end

  def test_brown_toast
    markdown = "__brown toast|Earth tone notification.__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui brown toast toast'>Earth tone notification.</div>", output
  end

  def test_grey_toast
    markdown = "__grey toast|Neutral notification.__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui grey toast toast'>Neutral notification.</div>", output
  end

  def test_black_toast
    markdown = "__black toast|Dark notification.__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui black toast toast'>Dark notification.</div>", output
  end

  def test_mini_toast
    markdown = "__mini toast|Small message.__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui mini toast toast'>Small message.</div>", output
  end

  def test_tiny_toast
    markdown = "__tiny toast|Tiny message.__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui tiny toast toast'>Tiny message.</div>", output
  end

  def test_small_toast
    markdown = "__small toast|Small message.__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui small toast toast'>Small message.</div>", output
  end

  def test_large_toast
    markdown = "__large toast|Large message.__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui large toast toast'>Large message.</div>", output
  end

  def test_big_toast
    markdown = "__big toast|Big message.__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui big toast toast'>Big message.</div>", output
  end

  def test_huge_toast
    markdown = "__huge toast|Huge message.__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui huge toast toast'>Huge message.</div>", output
  end

  def test_massive_toast
    markdown = "__massive toast|Massive message.__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui massive toast toast'>Massive message.</div>", output
  end
end