# coding: UTF-8

require_relative 'test_helper'

class TableTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_basic_table
    markdown = "
| Name | Age | City |
|------|-----|------|
| John | 25  | NYC  |
| Jane | 30  | LA   |
"
    output = @parser.render(markdown)
    assert_includes output, "<table class='ui table'>"
    assert_includes output, "<thead>"
    assert_includes output, "<tbody>"
    assert_includes output, "</table>"
  end

  def test_table_headers
    markdown = "
| Header 1 | Header 2 | Header 3 |
|----------|----------|----------|
| Data 1   | Data 2   | Data 3   |
"
    output = @parser.render(markdown)
    assert_includes output, "<th>Header 1</th>"
    assert_includes output, "<td>Data 1</td>"
  end

  def test_striped_table
    markdown = "
__Table: Striped__

| Column 1 | Column 2 |
|----------|----------|
| Row 1    | Data 1   |
| Row 2    | Data 2   |
"
    output = @parser.render(markdown)
    assert_includes output, "<table class='ui striped table'>"
  end

  def test_celled_table
    markdown = "__celled table|Header 1|Header 2|Data 1|Data 2__"
    output = @parser.render(markdown)
    assert_equal "<table class='ui celled table table'>Header 1|Header 2|Data 1|Data 2</table>", output
  end

  def test_padded_table
    markdown = "__padded table|Name|Age|John|25__"
    output = @parser.render(markdown)
    assert_equal "<table class='ui padded table table'>Name|Age|John|25</table>", output
  end

  def test_compact_table
    markdown = "__compact table|Col1|Col2|Val1|Val2__"
    output = @parser.render(markdown)
    assert_equal "<table class='ui compact table table'>Col1|Col2|Val1|Val2</table>", output
  end

  def test_very_compact_table
    markdown = "__very compact table|A|B|1|2__"
    output = @parser.render(markdown)
    assert_equal "<table class='ui very compact table table'>A|B|1|2</table>", output
  end

  def test_selectable_table
    markdown = "__selectable table|Item|Price|Book|$10__"
    output = @parser.render(markdown)
    assert_equal "<table class='ui selectable table table'>Item|Price|Book|$10</table>", output
  end

  def test_sortable_table
    markdown = "__sortable table|Name|Date|Alice|2024-01-15__"
    output = @parser.render(markdown)
    assert_equal "<table class='ui sortable table table'>Name|Date|Alice|2024-01-15</table>", output
  end

  def test_fixed_table
    markdown = "__fixed table|Column 1|Column 2|Fixed width|Also fixed__"
    output = @parser.render(markdown)
    assert_equal "<table class='ui fixed table table'>Column 1|Column 2|Fixed width|Also fixed</table>", output
  end

  def test_stackable_table
    markdown = "__stackable table|Desktop|Mobile|Full|Stacked__"
    output = @parser.render(markdown)
    assert_equal "<table class='ui stackable table table'>Desktop|Mobile|Full|Stacked</table>", output
  end

  def test_structured_table
    markdown = "__structured table|Header|Data|Row 1|Value 1__"
    output = @parser.render(markdown)
    assert_equal "<table class='ui structured table table'>Header|Data|Row 1|Value 1</table>", output
  end

  def test_basic_table_simple
    markdown = "__basic table|Simple|Basic|Clean|Look__"
    output = @parser.render(markdown)
    assert_equal "<table class='ui basic table table'>Simple|Basic|Clean|Look</table>", output
  end

  def test_very_basic_table
    markdown = "__very basic table|Minimal|Style|Less|Borders__"
    output = @parser.render(markdown)
    assert_equal "<table class='ui very basic table table'>Minimal|Style|Less|Borders</table>", output
  end

  def test_definition_table
    markdown = "__definition table|Term|Definition|Word|Meaning__"
    output = @parser.render(markdown)
    assert_equal "<table class='ui definition table table'>Term|Definition|Word|Meaning</table>", output
  end

  def test_collapsing_table
    markdown = "__collapsing table|Fit|Content|Auto|Width__"
    output = @parser.render(markdown)
    assert_equal "<table class='ui collapsing table table'>Fit|Content|Auto|Width</table>", output
  end

  def test_inverted_table
    markdown = "__inverted table|Dark|Theme|Black|Background__"
    output = @parser.render(markdown)
    assert_equal "<table class='ui inverted table table'>Dark|Theme|Black|Background</table>", output
  end

  def test_colored_table
    markdown = "__red table|Color|Theme|Branded|Table__"
    output = @parser.render(markdown)
    assert_equal "<table class='ui red table table'>Color|Theme|Branded|Table</table>", output
  end

  def test_small_table
    markdown = "__small table|Size|Small|Compact|Display__"
    output = @parser.render(markdown)
    assert_equal "<table class='ui small table table'>Size|Small|Compact|Display</table>", output
  end

  def test_large_table
    markdown = "__large table|Size|Large|Spacious|Display__"
    output = @parser.render(markdown)
    assert_equal "<table class='ui large table table'>Size|Large|Spacious|Display</table>", output
  end
end