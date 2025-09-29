# coding: UTF-8

require_relative 'test_helper'

class EmojiTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_basic_emoji
    markdown = ":smile:"
    output = @parser.render(markdown)
    assert_equal "<i class='ui emoji'>smile</i>", output
  end

  def test_multiple_emojis
    markdown = "I'm happy :smile: and excited :tada:"
    output = @parser.render(markdown)
    assert_includes output, "<i class='ui emoji'>"
    assert_includes output, "smile"
    assert_includes output, "tada"
  end

  def test_emoji_in_text
    markdown = "Welcome to our app! :wave:"
    output = @parser.render(markdown)
    assert_includes output, "Welcome to our app!"
    assert_includes output, "<i class='ui emoji'>wave</i>"
  end

  def test_heart_emoji
    markdown = "__emoji|heart__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui emoji emoji'>heart</i>", output
  end

  def test_thumbs_up_emoji
    markdown = "__emoji|thumbs_up__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui emoji emoji'>thumbs_up</i>", output
  end

  def test_fire_emoji
    markdown = "__emoji|fire__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui emoji emoji'>fire</i>", output
  end

  def test_star_emoji
    markdown = "__emoji|star__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui emoji emoji'>star</i>", output
  end

  def test_check_mark_emoji
    markdown = "__emoji|check_mark__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui emoji emoji'>check_mark</i>", output
  end

  def test_warning_emoji
    markdown = "__emoji|warning__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui emoji emoji'>warning</i>", output
  end

  def test_rocket_emoji
    markdown = "__emoji|rocket__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui emoji emoji'>rocket</i>", output
  end

  def test_party_emoji
    markdown = "__emoji|party__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui emoji emoji'>party</i>", output
  end

  def test_money_emoji
    markdown = "__emoji|money__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui emoji emoji'>money</i>", output
  end

  def test_light_bulb_emoji
    markdown = "__emoji|light_bulb__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui emoji emoji'>light_bulb</i>", output
  end

  def test_clock_emoji
    markdown = "__emoji|clock__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui emoji emoji'>clock</i>", output
  end

  def test_mail_emoji
    markdown = "__emoji|mail__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui emoji emoji'>mail</i>", output
  end

  def test_phone_emoji
    markdown = "__emoji|phone__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui emoji emoji'>phone</i>", output
  end

  def test_computer_emoji
    markdown = "__emoji|computer__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui emoji emoji'>computer</i>", output
  end

  def test_globe_emoji
    markdown = "__emoji|globe__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui emoji emoji'>globe</i>", output
  end

  def test_house_emoji
    markdown = "__emoji|house__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui emoji emoji'>house</i>", output
  end

  def test_car_emoji
    markdown = "__emoji|car__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui emoji emoji'>car</i>", output
  end

  def test_food_emoji
    markdown = "__emoji|food__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui emoji emoji'>food</i>", output
  end

  def test_weather_emoji
    markdown = "__emoji|weather__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui emoji emoji'>weather</i>", output
  end

  def test_sports_emoji
    markdown = "__emoji|sports__"
    output = @parser.render(markdown)
    assert_equal "<i class='ui emoji emoji'>sports</i>", output
  end
end