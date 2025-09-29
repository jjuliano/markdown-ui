# coding: UTF-8

require_relative 'test_helper'

class ProgressTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_basic_progress
    markdown = "__progress|75__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui progress progress'>75</div>", output
  end

  def test_indicating_progress
    markdown = "__indicating progress|60__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui indicating progress progress'>60</div>", output
  end

  def test_success_progress
    markdown = "__success progress|100__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui success progress progress'>100</div>", output
  end

  def test_error_progress
    markdown = "__error progress|25__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui error progress progress'>25</div>", output
  end

  def test_warning_progress
    markdown = "__warning progress|80__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui warning progress progress'>80</div>", output
  end

  def test_active_progress
    markdown = "__active progress|45__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui active progress progress'>45</div>", output
  end

  def test_disabled_progress
    markdown = "__disabled progress|30__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui disabled progress progress'>30</div>", output
  end

  def test_inverted_progress
    markdown = "__inverted progress|90__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui inverted progress progress'>90</div>", output
  end

  def test_colored_progress
    markdown = "__red progress|50__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui red progress progress'>50</div>", output
  end

  def test_blue_progress
    markdown = "__blue progress|70__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui blue progress progress'>70</div>", output
  end

  def test_green_progress
    markdown = "__green progress|85__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui green progress progress'>85</div>", output
  end

  def test_tiny_progress
    markdown = "__tiny progress|40__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui tiny progress progress'>40</div>", output
  end

  def test_small_progress
    markdown = "__small progress|55__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui small progress progress'>55</div>", output
  end

  def test_large_progress
    markdown = "__large progress|65__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui large progress progress'>65</div>", output
  end

  def test_big_progress
    markdown = "__big progress|75__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui big progress progress'>75</div>", output
  end
end