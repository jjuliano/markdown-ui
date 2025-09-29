# coding: UTF-8

require_relative 'test_helper'

class IconTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  # Note: Standalone icons appear to have parsing issues in the current implementation.
  # Icons work best as properties within other components like buttons.

  def test_icon_as_button_property
    markdown = "__button|Icon:home,Text:Home__"
    output = @parser.render(markdown)
    assert_includes output, "<button class='ui button'>"
    assert_includes output, "<i class='home icon'></i>"
    assert_includes output, "Home"
  end

  def test_icon_in_button
    markdown = "__button|Icon:user,Text:Profile__"
    output = @parser.render(markdown)
    assert_includes output, "<button class='ui button'>"
    assert_includes output, "<i class='user icon'></i>"
    assert_includes output, "Profile"
  end

  def test_basic_icon
    markdown = "__icon|home__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui home icon'></i>", output
  end

  def test_large_icon
    markdown = "__large icon|settings__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui large settings icon'></i>", output
  end

  def test_huge_icon
    markdown = "__huge icon|star__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui huge star icon'></i>", output
  end

  def test_massive_icon
    markdown = "__massive icon|heart__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui massive heart icon'></i>", output
  end

  def test_colored_icon
    markdown = "__red icon|error__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui red error icon'></i>", output
  end

  def test_blue_icon
    markdown = "__blue icon|info__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui blue info icon'></i>", output
  end

  def test_green_icon
    markdown = "__green icon|check__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui green check icon'></i>", output
  end

  def test_circular_icon
    markdown = "__circular icon|plus__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui circular plus icon'></i>", output
  end

  def test_bordered_icon
    markdown = "__bordered icon|mail__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui bordered mail icon'></i>", output
  end

  def test_inverted_icon
    markdown = "__inverted icon|search__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui inverted search icon'></i>", output
  end

  def test_loading_icon
    markdown = "__loading icon|spinner__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui loading spinner icon'></i>", output
  end

  def test_fitted_icon
    markdown = "__fitted icon|help__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui fitted help icon'></i>", output
  end

  def test_link_icon
    markdown = "__link icon|external__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui link external icon'></i>", output
  end

  def test_flipped_icon
    markdown = "__horizontally flipped icon|shield__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui horizontally flipped shield icon'></i>", output
  end

  def test_rotated_icon
    markdown = "__clockwise rotated icon|refresh__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui clockwise rotated refresh icon'></i>", output
  end
end