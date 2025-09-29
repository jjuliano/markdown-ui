# coding: UTF-8

require_relative 'test_helper'

class CalendarTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_basic_calendar
    markdown = "__calendar|2024-01-15__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui calendar' data-type='date' data-date='2024-01-15'><div class='ui input left icon'><input type='text' placeholder='Date'><i class='calendar icon'></i></div></div>", output 
  end

  def test_inline_calendar
    markdown = "__inline calendar|Today__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui inline calendar' data-type='date' data-date='Today'><div class='ui input left icon'><input type='text' placeholder='Date'><i class='calendar icon'></i></div></div>", output
  end

  def test_date_picker
    markdown = "__date picker calendar|Select Date__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui date picker calendar' data-type='date' data-date='Select Date'><div class='ui input left icon'><input type='text' placeholder='Date'><i class='calendar icon'></i></div></div>", output
  end

  def test_time_picker
    markdown = "__time picker calendar|Select Time__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui time picker calendar' data-type='time' data-time='Select Time'><div class='ui input left icon'><input type='text' placeholder='Time'><i class='clock icon'></i></div></div>", output
  end

  def test_datetime_picker
    markdown = "__datetime picker calendar|Select Date & Time__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui datetime picker calendar' data-type='datetime' data-datetime='Select Date & Time'><div class='ui input left icon'><input type='text' placeholder='Date & Time'><i class='calendar icon'></i></div></div>", output
  end

  def test_standard_calendar
    markdown = "__calendar|Date/Time__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui calendar' data-type='date' data-date='Date/Time'><div class='ui input left icon'><input type='text' placeholder='Date'><i class='calendar icon'></i></div></div>", output
  end

  def test_range_calendar
    markdown = "__range calendar|Start - End__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui range calendar' data-type='date' data-date='Start - End'><div class='ui input left icon'><input type='text' placeholder='Date'><i class='calendar icon'></i></div></div>", output
  end

  def test_multimonth_calendar
    markdown = "__multimonth calendar|Select Month__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui multimonth calendar calendar'>Select Month</div>", output
  end

  def test_year_first_calendar
    markdown = "__year first calendar|2024__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui year first calendar calendar'>2024</div>", output
  end

  def test_month_year_calendar
    markdown = "__month year calendar|2024-01__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui month year calendar calendar'>2024-01</div>", output
  end

  def test_year_calendar
    markdown = "__year calendar|2024__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui year calendar calendar'>2024</div>", output
  end

  def test_day_first_calendar
    markdown = "__day first calendar|15/01/2024__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui day first calendar calendar'>15/01/2024</div>", output
  end

  def test_button_calendar
    markdown = "__button calendar|Select date__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui button calendar calendar'>Select date</div>", output
  end

  def test_fluid_calendar
    markdown = "__fluid calendar|Pick a date__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui fluid calendar calendar'>Pick a date</div>", output
  end

  def test_datetime_calendar
    markdown = "__datetime calendar|2024-01-15 12:30 PM__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui datetime calendar' data-type='datetime' data-datetime='2024-01-15 12:30 PM'><div class='ui input left icon'><input type='text' placeholder='Date & Time'><i class='calendar icon'></i></div></div>", output
  end

  def test_time_calendar
    markdown = "__time calendar|12:30 PM__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui time calendar' data-type='time' data-time='12:30 PM'><div class='ui input left icon'><input type='text' placeholder='Time'><i class='time icon'></i></div></div>", output
  end
end