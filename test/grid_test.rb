# coding: UTF-8

require_relative 'test_helper'

class GridTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_basic_grid
    markdown = "
> Grid:
> ## Grid Layout
> > Column 1 | Column 2 | Column 3
> > Column 1 | Column 2 | Column 3
"
    output = @parser.render(markdown)
    assert_includes output, "<article class='ui grid'>"
    assert_includes output, "</article>"
  end

  def test_grid_with_rows
    markdown = "
Row 1 Content
---
Row 2 Content
"
    output = @parser.render(markdown)
    assert_includes output, "<article class='ui grid'>"
  end

  def test_responsive_grid
    markdown = "
### Mobile | Tablet | Computer
Content | Content | Content
"
    output = @parser.render(markdown)
    assert_includes output, "<article class='ui grid'>"
    assert_includes output, "</article>"
  end

  def test_two_column_grid
    markdown = "__two column grid|Left Content|Right Content__"
    output = @parser.render(markdown)
    assert_equal "<article class='ui two column grid'>Left Content|Right Content</article>", output
  end

  def test_three_column_grid
    markdown = "__three column grid|Column 1|Column 2|Column 3__"
    output = @parser.render(markdown)
    assert_equal "<article class='ui three column grid'>Column 1|Column 2|Column 3</article>", output
  end

  def test_four_column_grid
    markdown = "__four column grid|Col 1|Col 2|Col 3|Col 4__"
    output = @parser.render(markdown)
    assert_equal "<article class='ui four column grid'>Col 1|Col 2|Col 3|Col 4</article>", output
  end

  def test_equal_height_grid
    markdown = "__equal height grid|Content A|Content B__"
    output = @parser.render(markdown)
    assert_equal "<article class='ui equal height grid'>Content A|Content B</article>", output
  end

  def test_stackable_grid
    markdown = "__stackable grid|Mobile First|Desktop Second__"
    output = @parser.render(markdown)
    assert_equal "<article class='ui stackable grid'>Mobile First|Desktop Second</article>", output
  end

  def test_divided_grid
    markdown = "__divided grid|Section 1|Section 2__"
    output = @parser.render(markdown)
    assert_equal "<article class='ui divided grid'>Section 1|Section 2</article>", output
  end

  def test_celled_grid
    markdown = "__celled grid|Cell A|Cell B__"
    output = @parser.render(markdown)
    assert_equal "<article class='ui celled grid'>Cell A|Cell B</article>", output
  end

  def test_relaxed_grid
    markdown = "__relaxed grid|Spaced Content 1|Spaced Content 2__"
    output = @parser.render(markdown)
    assert_equal "<article class='ui relaxed grid'>Spaced Content 1|Spaced Content 2</article>", output
  end

  def test_very_relaxed_grid
    markdown = "__very relaxed grid|More Space 1|More Space 2__"
    output = @parser.render(markdown)
    assert_equal "<article class='ui very relaxed grid'>More Space 1|More Space 2</article>", output
  end

  def test_centered_grid
    markdown = "__centered grid|Centered Content__"
    output = @parser.render(markdown)
    assert_equal "<article class='ui centered grid'>Centered Content</article>", output
  end

  def test_padded_grid
    markdown = "__padded grid|Padded Content A|Padded Content B__"
    output = @parser.render(markdown)
    assert_equal "<article class='ui padded grid'>Padded Content A|Padded Content B</article>", output
  end
end