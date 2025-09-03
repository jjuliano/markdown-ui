# coding: UTF-8
require_relative 'test_helper'

class DividerTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_divider
    markdown =
        '
___
'

    output = @parser.parse(markdown)
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

    output = @parser.parse(markdown)
    assert_equal \
"<div class=\"ui two very relaxed stackable aligned grid\">\n  <div class=\"row\">\n    <div class=\"eight wide column\"><div class=\"ui column\"><form class=\"ui form\">\n  Field:\n  __Label Tag|Username__\n  Left Icon Input:\n  __Input|Text|Username__\n  _User Icon_\n\n<!-- -->\n  Field:\n  __Label Tag|Password__\n  Left Icon Input:\n  __Input|Password|Password__\n  _Lock Icon_\n\n<!-- -->\n  __Blue Submit Button|Login__\n</form>\n</div>\n</div>\n    <div class=\"eight wide column\">&lt;!-- --&gt;</div>\n  </div>\n  <div class=\"row\">\n    <div class=\"eight wide column\"><div class=\"ui vertical divider\">Or</div></div>\n    <div class=\"eight wide column\">&lt;!-- --&gt;</div>\n  </div>\n  <div class=\"row\">\n    <div class=\"eight wide column\"><div class=\"ui center aligned column\"><button class=\"ui big green labeled icon button\"><i class=\"signup icon\"></i>Sign Up</button></div></div>\n  </div>\n</div>", output
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

    output = @parser.parse(markdown)
    assert_equal \
"<section class=\"ui center aligned basic segment\">\n  <section class=\"ui center aligned basic segment\">Left Icon Action Input:\n  _Search Icon_\n  __Input|Text|Order #__\n  __Blue Submit Button|Search__\n\n<!-- -->\n  <div class=\"ui horizontal divider\"></div>\n  <div><p>Or</p>\n  </div>\n\n<!-- -->\n  <p><strong>Teal Labeled Icon Button|Create New Order, Icon: Add Icon</strong></p>\n  </section>\n</section>\n", output
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

    output = @parser.parse(markdown)
    assert_equal \
"<div class=\"ui horizontal header divider\"><p>_Tag Icon_\nDescription</p></div>\n\n<!-- -->\n<p>Doggie treats are good for all times of the year. Proven to be eaten by 99.9% of all dogs worldwide.</p>\n\n<!-- -->\n<div class=\"ui horizontal header divider\"><p>_Bar Chart Icon_\nSpecifications</p></div>\n\n<!-- -->\n\n<table class=\"ui definition table\">\n  <tbody>\n    <tr>\n      <td class=\"two wide column\">Size</td>\n      <td>1\" x 2\"</td>\n    </tr>\n    <tr>\n      <td>Weight</td>\n      <td>6 ounces</td>\n    </tr>\n    <tr>\n      <td>Color</td>\n      <td>Yellowish</td>\n    </tr>\n    <tr>\n      <td>Odor</td>\n      <td>Not Much Usually</td>\n    </tr>\n  </tbody>\n</table>\n", output
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

    output = @parser.parse(markdown)
    assert_equal \
"<div class=\"ui inverted segment\">\n  <p></p>\n<!-- -->\n  <div class=\"ui divider\"></div>\n  <p></p>\n<!-- -->\n  <div class=\"ui horizontal inverted divider header\">\n    <p>Horizontal</p>\n  </div>\n</div>\n", output
  end

  def test_fitted_variation
    markdown =
        '
> Segment:
> "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros. Nullam malesuada erat ut turpis. Suspendisse urna nibh, viverra non, semper suscipit, posuere a, pede."
> > Fitted Divider:
> > &nbsp;
>
> Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros. Nullam malesuada erat ut turpis. Suspendisse urna nibh, viverra non, semper suscipit, posuere a, pede.
'

    output = @parser.parse(markdown)
    assert_equal \
"<section class=\"ui segment\"><p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros. Nullam malesuada erat ut turpis. Suspendisse urna nibh, viverra non, semper suscipit, posuere a, pede.</p>\n<div class=\"ui fitted divider\"></div>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros. Nullam malesuada erat ut turpis. Suspendisse urna nibh, viverra non, semper suscipit, posuere a, pede.</section>", output
  end

  def test_hidden_variation
    markdown =
        '
> Segment:
> ### Section One
> "Lorem Ipsum Dolor"
> > Hidden Divider:
> > &nbsp;
>
> ### Section Two
> "Lorem Ipsum Dolor"
'

    output = @parser.parse(markdown)
    assert_equal \
"<section class=\"ui segment\">\n  <h3 class=\"ui header\">Section One</h3>\n  <p>Lorem Ipsum Dolor</p>\n  <div class=\"ui hidden divider\"></div>\n  <h3 class=\"ui header\">Section Two</h3>\n  <p>Lorem Ipsum Dolor</p>\n</section>\n", output
  end

  def test_section_variation
    markdown =
        '
> Segment:
> ### Section One
> "Lorem Ipsum Dolor"
> > Section Divider:
> > &nbsp;
>
> ### Section Two
> "Lorem Ipsum Dolor"
'

    output = @parser.parse(markdown)
    assert_equal \
"<div class=\"ui segment\">\n  <h3 class=\"ui header\">Section One</h3>\n  <p>Lorem Ipsum Dolor</p>\n  <div class=\"ui section divider\"></div>\n  <h3 class=\"ui header\">Section Two</h3>\n  <p>Lorem Ipsum Dolor</p>\n</div>\n", output
  end

  def test_floated_variation
    markdown =
        '
> Segment:
> > Right Floated Header:
> > Floated Content
>
> <!-- -->
> > Clearing Divider:
> > &nbsp;
>
> "Lorem Ipsum Dolor"
'

    output = @parser.parse(markdown)
    assert_equal \
"<section class=\"ui segment\">\n  <section class=\"ui segment\">Right Floated Header:\n  Floated Content\n\n<!-- -->\n  <div class=\"ui clearing divider\"></div>\n  <p>&gt; &amp;nbsp;\n\n  Lorem Ipsum Dolor</p></section>\n</section>\n", output
  end


end
