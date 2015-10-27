# coding: UTF-8
require_relative 'test_helper'

class DividerTest < Redcarpet::TestCase
  def setup
    @parser = Redcarpet::Markdown.new(MarkdownUI::Renderer, quote: true)
  end

  def test_divider
    markdown =
'
___
'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui divider"></div>', output
  end

  def test_vertical_divider
    markdown =
'
> Two Column Middle Aligned Very Relaxed Stackable Grid:
> > Column:
> > > Form:
> > > > Field:
> > > > __Label Tag|Username__
> > > > > Left Icon Input:
> > > > > __Input|Text|Username__
> > > > > _User Icon_
> > >
> > > <!-- -->
> > > > Field:
> > > > __Label Tag|Password__
> > > > > Left Icon Input:
> > > > > __Input|Password|Password__
> > > > > _Lock Icon_
> > >
> > > <!-- -->
> > > __Blue Submit Button|Login__
>
> <!-- -->
> > Vertical Divider:
> > Or
>
> <!-- -->
> > Center Aligned Column:
> > __Big Green Labeled Icon Button|Icon:Signup, Sign Up__
'

    output = @parser.render(markdown)
    assert_equal \
"<div class=\"ui two column middle aligned very relaxed stackable grid\">\n  <div class=\"ui column\">\n    <div class=\"ui form\">\n      <div class=\"ui field\">\n        <label>Username</label>\n        <div class=\"ui left icon input\">\n          <input type=\"text\" placeholder=\"Username\" class=\"ui input\" />\n          <i class=\"user icon\"></i>\n        </div>\n      </div>\n<!-- -->\n      <div class=\"ui field\">\n        <label>Password</label>\n        <div class=\"ui left icon input\">\n          <input type=\"password\" placeholder=\"Password\" class=\"ui input\" />\n          <i class=\"lock icon\"></i>\n        </div>\n      </div>\n<!-- -->\n      <button class=\"ui blue submit button\">Login</button>\n    </div>\n  </div>\n<!-- -->\n  <div class=\"ui vertical divider\">Or</div>\n<!-- -->\n  <div class=\"ui center aligned column\">\n    <button class=\"ui big green labeled icon button\"><i class=\"signup icon\"></i>Sign Up</button>\n  </div>\n</div>\n", output
  end

  def test_horizontal_divider
    markdown =
'
> Center Aligned Basic Segment:
> > Left Icon Action Input:
> > _Search Icon_
> > __Input|Text|Order #__
> > __Blue Submit Button|Search__
>
> <!-- -->
> > Horizontal Divider:
> > Or
>
> <!-- -->
> __Teal Labeled Icon Button|Create New Order, Icon: Add Icon__
'

    output = @parser.render(markdown)
    assert_equal \
"<div class=\"ui center aligned basic segment\">\n  <div class=\"ui left icon action input\">\n    <i class=\"search icon\"></i>\n    <input type=\"text\" placeholder=\"Order #\" class=\"ui input\" />\n    <button class=\"ui blue submit button\">Search</button>\n  </div>\n<!-- -->\n  <div class=\"ui horizontal divider\">Or</div>\n<!-- -->\n  <button class=\"ui teal labeled icon button\">Create New Order<i class=\"add icon\"></i></button>\n</div>\n", output
  end

  def test_horizontal_divider_table
    markdown =
'
> Horizontal Divider Header:
> _Tag Icon_
> Description

<!-- -->
"Doggie treats are good for all times of the year. Proven to be eaten by 99.9% of all dogs worldwide."

<!-- -->
> Horizontal Divider Header:
> _Bar Chart Icon_
> Specifications

<!-- -->
<table class="ui definition table">
  <tbody>
    <tr>
      <td class="two wide column">Size</td>
      <td>1" x 2"</td>
    </tr>
    <tr>
      <td>Weight</td>
      <td>6 ounces</td>
    </tr>
    <tr>
      <td>Color</td>
      <td>Yellowish</td>
    </tr>
    <tr>
      <td>Odor</td>
      <td>Not Much Usually</td>
    </tr>
  </tbody>
</table>
'

    output = @parser.render(markdown)
    assert_equal \
"<div class=\"ui horizontal divider header\"><i class=\"tag icon\"></i>\nDescription</div>\n\n<!-- -->\n<p>Doggie treats are good for all times of the year. Proven to be eaten by 99.9% of all dogs worldwide.</p>\n\n<!-- -->\n<div class=\"ui horizontal divider header\"><i class=\"bar chart icon\"></i>\nSpecifications</div>\n\n<!-- -->\n\n<table class=\"ui definition table\">\n  <tbody>\n    <tr>\n      <td class=\"two wide column\">Size</td>\n      <td>1\" x 2\"</td>\n    </tr>\n    <tr>\n      <td>Weight</td>\n      <td>6 ounces</td>\n    </tr>\n    <tr>\n      <td>Color</td>\n      <td>Yellowish</td>\n    </tr>\n    <tr>\n      <td>Odor</td>\n      <td>Not Much Usually</td>\n    </tr>\n  </tbody>\n</table>\n", output
  end

  def test_inverted_variation
    markdown =
'
> Inverted Segment:
> " "
>
> <!-- -->
> ___
> " "
>
> <!-- -->
> > Horizontal Inverted Divider Header:
> > "Horizontal"
'

    output = @parser.render(markdown)
    assert_equal \
"<div class=\"ui inverted segment\">\n  <p></p>\n<!-- -->\n  <div class=\"ui divider\"></div>\n  <p></p>\n<!-- -->\n  <div class=\"ui horizontal inverted divider header\">\n    <p>Horizontal</p>\n  </div>\n</div>\n", output
  end

end
