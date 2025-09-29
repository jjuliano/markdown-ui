# coding: UTF-8

require_relative 'test_helper'

class AccordionTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_basic_accordion
    markdown = "__accordion|Section 1|Content 1__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui accordion accordion'>Section 1|Content 1</div>", output
  end

  def test_styled_accordion
    markdown = "__styled accordion|Title|Content__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui styled accordion accordion'>Title|Content</div>", output
  end

  def test_fluid_accordion
    markdown = "__fluid accordion|Fluid Title|Fluid Content__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui fluid accordion accordion'>Fluid Title|Fluid Content</div>", output
  end

  def test_inverted_accordion
    markdown = "__inverted accordion|Dark Title|Dark Content__"
    output = @parser.render(markdown)
    assert_equal "<div class='ui inverted accordion accordion'>Dark Title|Dark Content</div>", output
  end
end