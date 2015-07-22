# coding: UTF-8
require_relative 'test_helper'

class ButtonTest < Redcarpet::TestCase
  def setup
    @parser = Redcarpet::Markdown.new(MarkdownUI::Renderer, quote: true)
  end

  def test_standard_button
    markdown = '__Klass Button|Text:Follow|ID__'
    output = @parser.render(markdown)
    assert_equal \
'<div id="id" class="ui klass button">Follow</div>
', output
  end

  def test_standard_button_2
    markdown = '__Button.Klass|Text:Follow|My ID__'
    output = @parser.render(markdown)
    assert_equal \
'<div id="my-id" class="ui klass button">Follow</div>
', output
  end

  def test_standard_button_alternative
    markdown = \
'
> Klass Button:
> Follow
'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui klass button">Follow</div>
', output
  end

  def test_standard_button_alternative_with_icon
    markdown =
'
> Klass Button:
> _Right Arrow Icon_
> Follow
'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui klass button"><i class="right arrow icon"></i> Follow</div>
', output
  end

  def test_standard_button_without_klass
    markdown = '__Button|Text:Follow__'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui button">Follow</div>
', output
  end

  def test_focusable_button
    markdown = '__Focusable Button|Text:Focusable Button|Focusable__'
    output = @parser.render(markdown)
    assert_equal \
'<button id="focusable" class="ui focusable button">Focusable Button</button>
', output
  end

  def test_focusable_button_2
    markdown = '__Button.Focusable|Text:Focusable Button__'
    output = @parser.render(markdown)
    assert_equal \
'<button class="ui focusable button">Focusable Button</button>
', output
  end

  def test_focusable_button_alternative
    markdown =
'
> Focusable Button:
> Focusable Button
'
    output = @parser.render(markdown)
    assert_equal \
'<button class="ui focusable button">Focusable Button</button>
', output
  end

  def test_focusable_button_without_klass
    markdown = '__Focusable Button|Text:Focusable Button__'
    output = @parser.render(markdown)
    assert_equal \
'<button class="ui focusable button">Focusable Button</button>
', output
  end

  def test_focusable_class_button
    markdown = '__Button.Focusable|Text:Focusable Button|Focusable__'
    output = @parser.render(markdown)
    assert_equal \
'<button id="focusable" class="ui focusable button">Focusable Button</button>
', output
  end

  def test_ordinality
    markdown1 = '__Primary Button|Text:Save|Primary__'
    markdown2 = '__Button|Text:Discard__'
    output1 = @parser.render(markdown1)
    output2 = @parser.render(markdown2)
    assert_equal \
'<div id="primary" class="ui primary button">Save</div>
', output1
    assert_equal \
'<div class="ui button">Discard</div>
', output2

    markdown3 = '__Secondary Button|Text:Save|Secondary__'
    markdown4 = '__Button|Text:Discard__'
    output3 = @parser.render(markdown3)
    output4 = @parser.render(markdown4)
    assert_equal \
'<div id="secondary" class="ui secondary button">Save</div>
', output3
    assert_equal \
'<div class="ui button">Discard</div>
', output4
  end

  def test_ordinality_alternative
    markdown1 =
'
> Primary Button:
> Save
'

    markdown2 =
'
> Button:
> Discard
'

    output1 = @parser.render(markdown1)
    output2 = @parser.render(markdown2)
    assert_equal \
'<div class="ui primary button">Save</div>
', output1
    assert_equal \
'<div class="ui button">Discard</div>
', output2

    markdown3 =
'
> Secondary Button:
> Save
'

    markdown4 =
'
> Button:
> Discard
'

    output3 = @parser.render(markdown3)
    output4 = @parser.render(markdown4)
    assert_equal \
'<div class="ui secondary button">Save</div>
', output3
    assert_equal \
'<div class="ui button">Discard</div>
', output4
  end

  def test_animated
    markdown = '__Animated Button|Text:Next;Icon:Right Arrow__'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui animated button">
  <div class="visible content">Next</div>
  <div class="hidden content">
    <i class="right arrow icon"></i>
  </div>
</div>
', output
  end

  def test_animated_alternative
    markdown =
'
> Animated Button:
> Next;
> _Right Arrow Icon_
'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui animated button">
  <div class="visible content">Next</div>
  <div class="hidden content">
    <i class="right arrow icon"></i>
  </div>
</div>
', output
  end

  def test_animated_alternative_versa
    markdown =
'
> Animated Button:
> _Right Arrow Icon_;
> Next
'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui animated button">
  <div class="visible content">
    <i class="right arrow icon"></i>
  </div>
  <div class="hidden content">Next</div>
</div>
', output
  end

  def test_animated_with_klass
    markdown = '__Animated Klass Button|Text:Next;Icon:Right Arrow|This is an ID__'
    output = @parser.render(markdown)
    assert_equal \
'<div id="this-is-an-id" class="ui animated klass button">
  <div class="visible content">Next</div>
  <div class="hidden content">
    <i class="right arrow icon"></i>
  </div>
</div>
', output
  end

  def test_vertical_animated
    markdown = '__Vertical Animated Button|Icon:Shop;Text:Shop|Vertical__'
    output = @parser.render(markdown)
    assert_equal \
'<div id="vertical" class="ui vertical animated button">
  <div class="visible content">
    <i class="shop icon"></i>
  </div>
  <div class="hidden content">Shop</div>
</div>
', output
  end

  def test_animated_fade
    markdown = '__Fade Animated Button|Text:Sign-up for a Pro account;Text:$12.99 a month|Fade__'
    output = @parser.render(markdown)
    assert_equal \
'<div id="fade" class="ui fade animated button">
  <div class="visible content">Sign-up for a Pro account</div>
  <div class="hidden content">$12.99 a month</div>
</div>
', output
  end

  def test_animated_fade_without_animated_mode_defined
    markdown = '__Fade Animated Button|Text:Sign-up for a Pro account:Visible Content,Text:$12.99 a month:Hidden Content|Fade Animated__'
    output = @parser.render(markdown)
    assert_equal \
'<div id="fade-animated" class="ui fade animated button">
  <div class="visible content">Sign-up for a Pro account</div>
  <div class="hidden content">$12.99 a month</div>
</div>
', output
  end

  def test_icon_button
    markdown = '__Icon Button|Icon:Cloud__'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui icon button">
  <i class="cloud icon"></i>
</div>
', output
  end

  def test_icon_button_alternative
    markdown =
'
> Icon Button:
> _Cloud Icon_
'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui icon button">
  <i class="cloud icon"></i>
</div>
', output
  end

  def test_multiple_elements_in_a_button
    markdown = '__Button|Icon:Cloud:Fluffy,Text:Literal Text,Icon:Cloud,Text:Cloud:Fluffy__'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui button"><i class="cloud fluffy icon"></i>Literal Text<i class="cloud icon"></i><div class="fluffy">Cloud</div></div>
', output
  end

  def test_icon_button_without_icon_mode_defined
    markdown = '__Icon Button|Icon:Cloud|Icon__'
    output = @parser.render(markdown)
    assert_equal \
'<div id="icon" class="ui icon button">
  <i class="cloud icon"></i>
</div>
', output
  end

  def test_labeled_icon_button
    markdown = '__Labeled Icon Button|Icon:Pause,Text:Pause__'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui labeled icon button"><i class="pause icon"></i>Pause</div>
', output
  end

  def test_labeled_icon_button_with_klass
    markdown = '__Right Labeled Icon Button|Icon:Right Arrow,Text:Next|Right__'
    output = @parser.render(markdown)
    assert_equal \
'<div id="right" class="ui right labeled icon button"><i class="right arrow icon"></i>Next</div>
', output
  end

  def test_labeled_icon_button_without_icon_mode_defined
    markdown = '__Labeled Icon Button|Icon:Pause,Text:Pause|Labeled Icon__'
    output = @parser.render(markdown)
    assert_equal \
'<div id="labeled-icon" class="ui labeled icon button"><i class="pause icon"></i>Pause</div>
', output
  end

  def test_basic_icon
    markdown = '__Basic Button|Icon:User,Text:Add Friend__'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui basic button"><i class="user icon"></i>Add Friend</div>
', output
  end

  def test_basic_icon_without_basic_mode_defined
    markdown = '__Basic Button|Icon:User,Text:Add Friend|Basic__'
    output = @parser.render(markdown)
    assert_equal \
'<div id="basic" class="ui basic button"><i class="user icon"></i>Add Friend</div>
', output
  end

  def test_custom_button
    markdown = '__Very Cool Button|Icon:User,Text:Add Friend__'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui very cool button"><i class="user icon"></i>Add Friend</div>
', output
  end

  def test_inverted_button
    markdown =
'
> Inverted Segment:
> __Inverted Button|Text: Standard|Inverted__
> __Inverted Black Button|Text: Black|Inverted Black__
> __Inverted Yellow Button|Text: Yellow|Inverted Yellow__
> __Inverted Green Button|Text: Green|Inverted Green__
> __Inverted Blue Button|Text: Blue|Inverted Blue__
> __Inverted Orange Button|Text: Orange|Inverted Orange__
> __Inverted Purple Button|Text: Purple|Inverted Purple__
> __Inverted Pink Button|Text: Pink|Inverted Pink__
> __Inverted Red Button|Text: Red|Inverted Red__
> __Inverted Teal Button|Text: Teal|Inverted Teal__
'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui inverted segment">
  <div id="inverted" class="ui inverted button">Standard</div>
  <div id="inverted-black" class="ui inverted black button">Black</div>
  <div id="inverted-yellow" class="ui inverted yellow button">Yellow</div>
  <div id="inverted-green" class="ui inverted green button">Green</div>
  <div id="inverted-blue" class="ui inverted blue button">Blue</div>
  <div id="inverted-orange" class="ui inverted orange button">Orange</div>
  <div id="inverted-purple" class="ui inverted purple button">Purple</div>
  <div id="inverted-pink" class="ui inverted pink button">Pink</div>
  <div id="inverted-red" class="ui inverted red button">Red</div>
  <div id="inverted-teal" class="ui inverted teal button">Teal</div>
</div>
', output
  end

  def test_basic_inverted_button
    markdown =
'
> Inverted Segment:
> __Basic Button|Text: Basic|Basic__
> __Basic Black Button|Text: Black Basic|Basic Black__
> __Basic Yellow Button|Text: Yellow Basic|Basic Yellow__
> __Basic Green Button|Text: Green Basic|Basic Green__
> __Basic Blue Button|Text: Blue Basic|Basic Blue__
> __Basic Orange Button|Text: Orange Basic|Basic Orange__
> __Basic Purple Button|Text: Purple Basic|Basic Purple__
> __Basic Pink Button|Text: Pink Basic|Basic Pink__
> __Basic Red Button|Text: Red Basic|Basic Red__
> __Basic Teal Button|Text: Teal Basic|Basic Teal__
'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui inverted segment">
  <div id="basic" class="ui basic button">Basic</div>
  <div id="basic-black" class="ui basic black button">Black Basic</div>
  <div id="basic-yellow" class="ui basic yellow button">Yellow Basic</div>
  <div id="basic-green" class="ui basic green button">Green Basic</div>
  <div id="basic-blue" class="ui basic blue button">Blue Basic</div>
  <div id="basic-orange" class="ui basic orange button">Orange Basic</div>
  <div id="basic-purple" class="ui basic purple button">Purple Basic</div>
  <div id="basic-pink" class="ui basic pink button">Pink Basic</div>
  <div id="basic-red" class="ui basic red button">Red Basic</div>
  <div id="basic-teal" class="ui basic teal button">Teal Basic</div>
</div>
', output
  end

  def test_group_buttons
    markdown =
'
> Buttons:
> __Standard Button|Text: One|Standard__
> __Standard Button|Text: Two|Standard__
> __Standard Button|Text: Three|Standard__
'
    output = @parser.render(markdown)
    assert_equal \
'<div class="ui buttons">
  <div id="standard" class="ui standard button">One</div>
  <div id="standard" class="ui standard button">Two</div>
  <div id="standard" class="ui standard button">Three</div>
</div>
', output
  end

  def test_icon_group_buttons
    markdown =
'
> Icon Buttons:
> __Button|Icon: Align Left__
> __Button|Icon: Align Center__
> __Button|Icon: Align Right__
> __Button|Icon: Align Justify__

" "

> Icon Buttons:
> __Button|Icon: Bold__
> __Button|Icon: Underline__
> __Button|Icon: Text Width__
'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui icon buttons">
  <div class="ui button">
    <i class="align left icon"></i>
  </div>
  <div class="ui button">
    <i class="align center icon"></i>
  </div>
  <div class="ui button">
    <i class="align right icon"></i>
  </div>
  <div class="ui button">
    <i class="align justify icon"></i>
  </div>
</div>
<p></p>
<div class="ui icon buttons">
  <div class="ui button">
    <i class="bold icon"></i>
  </div>
  <div class="ui button">
    <i class="underline icon"></i>
  </div>
  <div class="ui button">
    <i class="text width icon"></i>
  </div>
</div>
', output
  end

  def test_icon_group_conditionals
    markdown =
'
> Icon Buttons:
> __Button|Text: Cancel__
> __Div Tag||Or__
> __Positive Button|Text: Save|Positive__
'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui icon buttons">
  <div class="ui button">Cancel</div>
  <div class="or"></div>
  <div id="positive" class="ui positive button">Save</div>
</div>
', output
  end

  def test_icon_group_conditionals_with_data_attributes
    markdown =
'
> Icon Buttons:
> __Button|Text: un__
> __Div Tag||Or|Data:Text:ou__
> __Positive Button|Text: deux|Positive__
'

    output = @parser.render(markdown)
    assert_equal \
'<div class="ui icon buttons">
  <div class="ui button">un</div>
  <div class="or" data-text="ou"></div>
  <div id="positive" class="ui positive button">deux</div>
</div>
', output
  end
end
