# coding: UTF-8
require_relative 'test_helper'

class MenuTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_menu
    markdown =
        '
> Three Item Menu:
> [Editorials](# "active")
> [Reviews](#)
> [Upcoming Events](#)
'

    output = @parser.render(markdown)
    assert_equal "<nav class='ui three item menu'><a class='ui active item' href='#'>Editorials</a>\n  <a class='ui item' href='#'>Reviews</a>\n  <a class='ui item' href='#'>Upcoming Events</a></nav>", output
  end

  def test_menu_alternative
    markdown =
        '
__Three Item Menu|[Editorials](# "active") [Reviews](#) [Upcoming Events](#)__
'

    output = @parser.render(markdown)
    assert_equal "<nav class='ui three item menu'><a class='ui active item' href='#'>Editorials</a> <a class='ui item' href='#'>Reviews</a> <a class='ui item' href='#'>Upcoming Events</a></nav>", output
  end

  def test_secondary_menu
    markdown =
        '
> Secondary Menu:
> [Home](# "active")
> [Messages](#)
> [Friends](#)
> > Right Menu:
> > [Logout](#)
'

    output = @parser.render(markdown)
    assert_equal "<nav class='ui secondary menu'><a class='ui active item' href='#'>Home</a>\n  <a class='ui item' href='#'>Messages</a>\n  <a class='ui item' href='#'>Friends</a><nav class='ui right menu'><a class='ui item' href='#'>Logout</a></nav></nav>", output
  end

  def test_pointing_menu
    markdown =
        '
> Pointing Menu:
> [Home](# "active")
> [Messages](#)
> [Friends](#)
> > Right Menu:
> > [Logout](#)

" "

> Segment:
> " "
'

    output = @parser.render(markdown)
    assert_equal "<nav class='ui pointing menu'><a class='ui active item' href='#'>Home</a>\n  <a class='ui item' href='#'>Messages</a>\n  <a class='ui item' href='#'>Friends</a><nav class='ui right menu'><a class='ui item' href='#'>Logout</a></nav></nav><p></p><section class='ui segment'>\n  <p></p>\n</section>", output
  end

  def test_secondary_pointing_menu
    markdown =
        '
> Secondary Pointing Menu:
> [Home](# "active")
> [Messages](#)
> [Friends](#)
> > Right Menu:
> > [Logout](#)

" "

> Segment:
> " "
'

    output = @parser.render(markdown)
    assert_equal "<nav class='ui secondary pointing menu'><a class='ui active item' href='#'>Home</a>\n  <a class='ui item' href='#'>Messages</a>\n  <a class='ui item' href='#'>Friends</a><nav class='ui right menu'><a class='ui item' href='#'>Logout</a></nav></nav><p></p><section class='ui segment'>\n  <p></p>\n</section>", output
  end

  def test_tabular_menu
    markdown =
        '
> Tabular Menu:
> [Bio](# "active")
> [Photos](#)
'

    output = @parser.render(markdown)
    assert_equal "<nav class='ui tabular menu'><a class='ui active item' href='#'>Bio</a>\n  <a class='ui item' href='#'>Photos</a></nav>", output
  end

  def test_tabular_attached_menu
    markdown =
        '
> Top Attached Tabular Menu:
> [Bio](# "active")
> [Photos](#)
> > Right Menu:
> > [Logout](#)

" "

> Bottom Attached Segment:
> " "
'

    output = @parser.render(markdown)
    assert_equal "<nav class='ui top attached tabular menu'><a class='ui active item' href='#'>Bio</a>\n  <a class='ui item' href='#'>Photos</a><nav class='ui right menu'><a class='ui item' href='#'>Logout</a></nav></nav><p></p><section class='ui bottom attached segment'>\n  <p></p>\n</section>", output
  end

  def test_vertical_fluid_tabular_menu
    markdown =
        '
> Grid:
> > Four Wide Column:
> > > Vertical Fluid Tabular Menu:
> > > [Bio](# "active")
> > > [Pics](#)
> > > [Companies](#)
> > > [Links](#)
'

    output = @parser.render(markdown)
    assert_equal "<article class='ui grid'>\n  <section class='ui four wide column'><nav class='ui vertical fluid tabular menu'><a class='ui active item' href='#'>Bio</a>\n      <a class='ui item' href='#'>Pics</a>\n      <a class='ui item' href='#'>Companies</a>\n      <a class='ui item' href='#'>Links</a></nav></section>\n</article>", output
  end

  def test_text_menu
    markdown =
        '
> Text Menu:
> [Closest](# "active")
> [Most Comments](#)
> [Most Popular](#)
'

    output = @parser.render(markdown)
    assert_equal "<nav class='ui text menu'><a class='ui active item' href='#'>Closest</a>\n  <a class='ui item' href='#'>Most Comments</a>\n  <a class='ui item' href='#'>Most Popular</a></nav>", output
  end

  def test_vertical_menu
    markdown =
        '
> Vertical Menu:
> [Inbox __Div Tag|1|Teal Pointing Left Label__](# "active teal item")
> [Spam __Div Tag|51|Label__](#)
> [Updates __Div Tag|1|Label__](#)
'

    output = @parser.render(markdown)
    assert_equal "<nav class='ui vertical menu'><a class='ui active teal item' href='#'>Inbox \n    <div class='teal pointing left label'>1</div>\n  </a>\n  <a class='ui item' href='#'>Spam \n    <div class='label'>51</div>\n  </a>\n  <a class='ui item' href='#'>Updates \n    <div class='label'>1</div>\n  </a></nav>", output
  end

  def test_pagination_menu
    markdown =
        '
> Pagination Menu:
> [1](# "active")
> [...](# "disabled")
> [10](#)
> [11](#)
> [12](#)
'

    output = @parser.render(markdown)
    assert_equal "<nav class='ui pagination menu'><a class='ui active item' href='#'>1</a>\n  <a class='ui disabled item' href='#'>...</a>\n  <a class='ui item' href='#'>10</a>\n  <a class='ui item' href='#'>11</a>\n  <a class='ui item' href='#'>12</a></nav>", output
  end
end
