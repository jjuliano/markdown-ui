# coding: UTF-8
require_relative 'test_helper'

class MenuTest < Redcarpet::TestCase
  def setup
    @parser = Redcarpet::Markdown.new(MarkdownUI::Renderer, quote: true)
  end

  def test_menu
    markdown =
<<-EOS
> Three Item Menu:
> [Editorials](# "active")
> [Reviews](#)
> [Upcoming Events](#)
EOS

    output = @parser.render(markdown)
    assert_equal "<div class=\"ui three item menu\">\n  <a class=\"ui active item\">Editorials</a>\n  <a class=\"ui item\">Reviews</a>\n  <a class=\"ui item\">Upcoming Events</a>\n</div>\n", output
  end

  def test_menu_alternative
    markdown =
<<-EOS
__Three Item Menu|[Editorials](# "active") [Reviews](#) [Upcoming Events](#)__
EOS

    output = @parser.render(markdown)
    assert_equal "<div class=\"ui three item menu\">\n  <a class=\"ui active item\">Editorials</a>\n  <a class=\"ui item\">Reviews</a>\n  <a class=\"ui item\">Upcoming Events</a>\n</div>\n", output
  end

  def test_secondary_menu
    markdown =
<<-EOS
> Secondary Menu:
> [Home](# "active")
> [Messages](#)
> [Friends](#)
> > Right Menu:
> > [Logout](#)
EOS

    output = @parser.render(markdown)
    assert_equal "<div class=\"ui secondary menu\">\n  <a class=\"ui active item\">Home</a>\n  <a class=\"ui item\">Messages</a>\n  <a class=\"ui item\">Friends</a>\n  <div class=\"ui right menu\">\n    <a class=\"ui item\">Logout</a>\n  </div>\n</div>\n", output
  end

  def test_pointing_menu
    markdown =
<<-EOS
> Pointing Menu:
> [Home](# "active")
> [Messages](#)
> [Friends](#)
> > Right Menu:
> > [Logout](#)

" "

> Segment:
> " "
EOS

    output = @parser.render(markdown)
    assert_equal "<div class=\"ui pointing menu\">\n  <a class=\"ui active item\">Home</a>\n  <a class=\"ui item\">Messages</a>\n  <a class=\"ui item\">Friends</a>\n  <div class=\"ui right menu\">\n    <a class=\"ui item\">Logout</a>\n  </div>\n</div>\n<p></p>\n<div class=\"ui segment\">\n  <p></p>\n</div>\n", output
  end

  def test_secondary_pointing_menu
    markdown =
<<-EOS
> Secondary Pointing Menu:
> [Home](# "active")
> [Messages](#)
> [Friends](#)
> > Right Menu:
> > [Logout](#)

" "

> Segment:
> " "
EOS

    output = @parser.render(markdown)
    assert_equal "<div class=\"ui secondary pointing menu\">\n  <a class=\"ui active item\">Home</a>\n  <a class=\"ui item\">Messages</a>\n  <a class=\"ui item\">Friends</a>\n  <div class=\"ui right menu\">\n    <a class=\"ui item\">Logout</a>\n  </div>\n</div>\n<p></p>\n<div class=\"ui segment\">\n  <p></p>\n</div>\n", output
  end

  def test_tabular_menu
    markdown =
<<-EOS
> Tabular Menu:
> [Bio](# "active")
> [Photos](#)
EOS

    output = @parser.render(markdown)
    assert_equal "<div class=\"ui tabular menu\">\n  <a class=\"ui active item\">Bio</a>\n  <a class=\"ui item\">Photos</a>\n</div>\n", output
  end

  def test_tabular_attached_menu
    markdown =
<<-EOS
> Top Attached Tabular Menu:
> [Bio](# "active")
> [Photos](#)
> > Right Menu:
> > [Logout](#)

" "

> Bottom Attached Segment:
> " "
EOS

    output = @parser.render(markdown)
    assert_equal "<div class=\"ui top attached tabular menu\">\n  <a class=\"ui active item\">Bio</a>\n  <a class=\"ui item\">Photos</a>\n  <div class=\"ui right menu\">\n    <a class=\"ui item\">Logout</a>\n  </div>\n</div>\n<p></p>\n<div class=\"ui bottom attached segment\">\n  <p></p>\n</div>\n", output
  end

  def test_vertical_fluid_tabular_menu
    markdown =
<<-EOS
> Grid:
> > Four Wide Column:
> > > Vertical Fluid Tabular Menu:
> > > [Bio](# "active")
> > > [Pics](#)
> > > [Companies](#)
> > > [Links](#)
EOS

    output = @parser.render(markdown)
    assert_equal "<div class=\"ui grid\">\n  <div class=\"ui four wide column\">\n    <div class=\"ui vertical fluid tabular menu\">\n      <a class=\"ui active item\">Bio</a>\n      <a class=\"ui item\">Pics</a>\n      <a class=\"ui item\">Companies</a>\n      <a class=\"ui item\">Links</a>\n    </div>\n  </div>\n</div>\n", output
  end

  def test_text_menu
    markdown =
<<-EOS
> Text Menu:
> [Closest](# "active")
> [Most Comments](#)
> [Most Popular](#)
EOS

    output = @parser.render(markdown)
    assert_equal "<div class=\"ui text menu\">\n  <a class=\"ui active item\">Closest</a>\n  <a class=\"ui item\">Most Comments</a>\n  <a class=\"ui item\">Most Popular</a>\n</div>\n", output
  end

  def test_vertical_menu
    markdown =
<<-EOS
> Vertical Menu:
> [Inbox __Div Tag|1|Teal Pointing Left Label__](# "active teal item")
> [Spam __Div Tag|51|Label__](#)
> [Updates __Div Tag|1|Label__](#)
EOS

    output = @parser.render(markdown)
    assert_equal "<div class=\"ui vertical menu\">\n  <a class=\"ui active teal item\">Inbox <div class=\"teal pointing left label\">1</div></a>\n  <a class=\"ui item\">Spam <div class=\"label\">51</div></a>\n  <a class=\"ui item\">Updates <div class=\"label\">1</div></a>\n</div>\n", output
  end

  def test_pagination_menu
    markdown =
<<-EOS
> Pagination Menu:
> [1](# "active")
> [...](# "disabled")
> [10](#)
> [11](#)
> [12](#)
EOS

    output = @parser.render(markdown)
    assert_equal "<div class=\"ui pagination menu\">\n  <a class=\"ui active item\">1</a>\n  <a class=\"ui disabled item\">&hellip;</a>\n  <a class=\"ui item\">10</a>\n  <a class=\"ui item\">11</a>\n  <a class=\"ui item\">12</a>\n</div>\n", output
  end
end
