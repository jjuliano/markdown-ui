# coding: UTF-8
require_relative 'test_helper'

class MenuTest < Redcarpet::TestCase
  def setup
    @parser = Redcarpet::Markdown.new(MarkdownUI::Renderer, quote: true, tables: true, xhtml: true)
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
    assert_equal \
'<div class="ui three item menu">
  <a class="ui active item" href="#">Editorials</a>
  <a class="ui item" href="#">Reviews</a>
  <a class="ui item" href="#">Upcoming Events</a>
</div>
', output
  end

  def test_menu_alternative
    markdown =
'
__Three Item Menu|[Editorials](# "active") [Reviews](#) [Upcoming Events](#)__
'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui three item menu">
  <a class="ui active item" href="#">Editorials</a>
  <a class="ui item" href="#">Reviews</a>
  <a class="ui item" href="#">Upcoming Events</a>
</div>
', output
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
    assert_equal \
'<div class="ui secondary menu">
  <a class="ui active item" href="#">Home</a>
  <a class="ui item" href="#">Messages</a>
  <a class="ui item" href="#">Friends</a>
  <div class="ui right menu">
    <a class="ui item" href="#">Logout</a>
  </div>
</div>
', output
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
    assert_equal \
'<div class="ui pointing menu">
  <a class="ui active item" href="#">Home</a>
  <a class="ui item" href="#">Messages</a>
  <a class="ui item" href="#">Friends</a>
  <div class="ui right menu">
    <a class="ui item" href="#">Logout</a>
  </div>
</div>
<p></p>
<div class="ui segment">
  <p></p>
</div>
', output
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
    assert_equal \
'<div class="ui secondary pointing menu">
  <a class="ui active item" href="#">Home</a>
  <a class="ui item" href="#">Messages</a>
  <a class="ui item" href="#">Friends</a>
  <div class="ui right menu">
    <a class="ui item" href="#">Logout</a>
  </div>
</div>
<p></p>
<div class="ui segment">
  <p></p>
</div>
', output
  end

  def test_tabular_menu
    markdown =
'
> Tabular Menu:
> [Bio](# "active")
> [Photos](#)
'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui tabular menu">
  <a class="ui active item" href="#">Bio</a>
  <a class="ui item" href="#">Photos</a>
</div>
', output
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
    assert_equal \
'<div class="ui top attached tabular menu">
  <a class="ui active item" href="#">Bio</a>
  <a class="ui item" href="#">Photos</a>
  <div class="ui right menu">
    <a class="ui item" href="#">Logout</a>
  </div>
</div>
<p></p>
<div class="ui bottom attached segment">
  <p></p>
</div>
', output
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
    assert_equal \
'<div class="ui grid">
  <div class="ui four wide column">
    <div class="ui vertical fluid tabular menu">
      <a class="ui active item" href="#">Bio</a>
      <a class="ui item" href="#">Pics</a>
      <a class="ui item" href="#">Companies</a>
      <a class="ui item" href="#">Links</a>
    </div>
  </div>
</div>
', output
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
    assert_equal \
'<div class="ui text menu">
  <a class="ui active item" href="#">Closest</a>
  <a class="ui item" href="#">Most Comments</a>
  <a class="ui item" href="#">Most Popular</a>
</div>
', output
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
    assert_equal \
'<div class="ui vertical menu">
  <a class="ui active teal item" href="#">Inbox <div class="teal pointing left label">1</div></a>
  <a class="ui item" href="#">Spam <div class="label">51</div></a>
  <a class="ui item" href="#">Updates <div class="label">1</div></a>
</div>
', output
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
    assert_equal \
'<div class="ui pagination menu">
  <a class="ui active item" href="#">1</a>
  <a class="ui disabled item" href="#">...</a>
  <a class="ui item" href="#">10</a>
  <a class="ui item" href="#">11</a>
  <a class="ui item" href="#">12</a>
</div>
', output
  end
end
