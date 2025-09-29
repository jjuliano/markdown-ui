# coding: UTF-8

require_relative 'test_helper'

class BreadcrumbTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_basic_breadcrumb
    markdown = "__Breadcrumb|Home / Library / Data__"
    output = @parser.render(markdown)
    assert_equal "<nav class='ui breadcrumb'><a class='section' href='#'>Home</a><div class='divider'> / </div> <a class='section' href='#'>Library</a> <div class='divider'> / </div> <a class='section' href='#'>Data</a></nav>", output
  end

  def test_basic_breadcrumb_with_links
    markdown = "__Breadcrumb|[Home](/home) / [Library](/library) / Data__"
    output = @parser.render(markdown)
    assert_equal "<nav class='ui breadcrumb'><a class='section' href='/home'>Home</a><div class='divider'> / </div> <a class='section' href='/library'>Library</a> <div class='divider'> / </div> <a class='section' href='#'>Data</a></nav>", output
  end

  def test_basic_breadcrumb_with_selected_links
    markdown = "__Breadcrumb|[Home](/home) / *[Library](/library) / Data__"
    output = @parser.render(markdown)
    assert_equal "<nav class='ui breadcrumb'><a class='section' href='/home'>Home</a><div class='divider'> / </div> <a class='active section' href='/library'>Library</a> <div class='divider'> / </div> <a class='section' href='#'>Data</a></nav>", output
  end

  def test_breadcrumb_with_divider
    markdown = "__Breadcrumb|Home → Library → *Data__"
    output = @parser.render(markdown)
    assert_equal "<nav class='ui breadcrumb'><a class='section' href='#'>Home</a><div class='divider'> → </div> <a class='section' href='#'>Library</a> <div class='divider'> → </div> <a class='active section' href='#'>Data</a></nav>", output
  end

  def test_breadcrumb_with_chevron_divider
    markdown = "__Breadcrumb|*Home > Library > Data__"
    output = @parser.render(markdown)
    assert_equal "<nav class='ui breadcrumb'><a class='active section' href='#'>Home</a><i class='right chevron icon divider'></i> <a class='section' href='#'>Library</a> <i class='right chevron icon divider'></i> <a class='section' href='#'>Data</a></nav>", output
  end

  def test_mini_breadcrumb
    markdown = "__mini breadcrumb|Home / Page__"
    output = @parser.render(markdown)
    assert_equal "<nav class='ui mini breadcrumb'><a class='section' href='#'>Home</a><div class='divider'> / </div> <a class='section' href='#'>Page</a></nav>", output
  end

  def test_tiny_breadcrumb
    markdown = "__tiny breadcrumb|Home / Section / Page__"
    output = @parser.render(markdown)
    assert_equal "<nav class='ui tiny breadcrumb'><a class='section' href='#'>Home</a><div class='divider'> / </div> <a class='section' href='#'>Section</a> <div class='divider'> / </div> <a class='section' href='#'>Page</a></nav>", output
  end

  def test_small_breadcrumb
    markdown = "__small breadcrumb|Home / Category / Item__"
    output = @parser.render(markdown)
    assert_equal "<nav class='ui small breadcrumb'><a class='section' href='#'>Home</a><div class='divider'> / </div> <a class='section' href='#'>Category</a> <div class='divider'> / </div> <a class='section' href='#'>Item</a></nav>", output
  end

  def test_large_breadcrumb
    markdown = "__large breadcrumb|Dashboard / Settings / Profile__"
    output = @parser.render(markdown)
    assert_equal "<nav class='ui large breadcrumb'><a class='section' href='#'>Dashboard</a><div class='divider'> / </div> <a class='section' href='#'>Settings</a> <div class='divider'> / </div> <a class='section' href='#'>Profile</a></nav>", output
  end

  def test_big_breadcrumb
    markdown = "__big breadcrumb|Store / Electronics / Phones__"
    output = @parser.render(markdown)
    assert_equal "<nav class='ui big breadcrumb'><a class='section' href='#'>Store</a><div class='divider'> / </div> <a class='section' href='#'>Electronics</a> <div class='divider'> / </div> <a class='section' href='#'>Phones</a></nav>", output
  end

  def test_huge_breadcrumb
    markdown = "__huge breadcrumb|Portal / Admin / Users__"
    output = @parser.render(markdown)
    assert_equal "<nav class='ui huge breadcrumb'><a class='section' href='#'>Portal</a><div class='divider'> / </div> <a class='section' href='#'>Admin</a> <div class='divider'> / </div> <a class='section' href='#'>Users</a></nav>", output
  end

  def test_massive_breadcrumb
    markdown = "__massive breadcrumb|System / Configuration / Advanced__"
    output = @parser.render(markdown)
    assert_equal "<nav class='ui massive breadcrumb'><a class='section' href='#'>System</a><div class='divider'> / </div> <a class='section' href='#'>Configuration</a> <div class='divider'> / </div> <a class='section' href='#'>Advanced</a></nav>", output
  end

  def test_icon_breadcrumb
    markdown = "__icon breadcrumb|🏠 Home / 📁 Documents / 📄 File__"
    output = @parser.render(markdown)
    assert_equal "<nav class='ui icon breadcrumb'><a class='section' href='#'>🏠 Home</a><div class='divider'> / </div> <a class='section' href='#'>📁 Documents</a> <div class='divider'> / </div> <a class='section' href='#'>📄 File</a></nav>", output
  end
end