# coding: UTF-8

require_relative 'test_helper'

class ModalTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_basic_modal
    markdown = "__modal|Modal Content__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui modal modal'>Modal Content</div>", output
  end

  def test_small_modal
    markdown = "__small modal|Small Modal__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui small modal modal'>Small Modal</div>", output
  end

  def test_large_modal
    markdown = "__large modal|Large Modal__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui large modal modal'>Large Modal</div>", output
  end

  def test_fullscreen_modal
    markdown = "__fullscreen modal|Fullscreen Modal__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui fullscreen modal modal'>Fullscreen Modal</div>", output
  end

  def test_basic_modal_with_close
    markdown = "__basic modal|Basic Modal__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui basic modal modal'>Basic Modal</div>", output
  end

  def test_inverted_modal
    markdown = "__inverted modal|Dark Modal__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui inverted modal modal'>Dark Modal</div>", output
  end
end