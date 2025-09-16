# coding: UTF-8
require_relative 'test_helper'

class ButtonTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_standard_button
    markdown = '__Klass Button|Text:Follow|ID__'
    output   = @parser.render(markdown)
    assert_equal "<button id='id' class='ui klass button'>Follow</button>", output
  end

  def test_standard_button_2
    markdown = '__Button.Klass|Text:Follow|My ID__'
    output   = @parser.render(markdown)
    assert_equal "<button id='my-id' class='ui klass button'>Follow</button>", output
  end

  def test_standard_button_alternative
    markdown = \
'
> Klass Button:
> Follow
'

    output = @parser.render(markdown)
    assert_equal "<button class='ui klass button'>Follow</button>", output
  end

  def test_standard_button_alternative_with_icon
    markdown =
        '
> Klass Button:
> _Right Arrow Icon_
> Follow
'

    output = @parser.render(markdown)
    assert_equal "<button class='ui klass button'><i class='right arrow icon'></i>\n  Follow</button>", output
  end

  def test_standard_button_without_klass
    markdown = '__Button|Text:Follow__'
    output   = @parser.render(markdown)
    assert_equal "<button class='ui button'>Follow</button>", output
  end

  def test_focusable_button
    markdown = '__Focusable Button|Text:Focusable Button|Focusable__'
    output   = @parser.render(markdown)
    assert_equal "<div id='focusable' class='ui focusable button' tabindex='0'>Focusable Button</div>", output
  end

  def test_focusable_button_2
    markdown = '__Button.Focusable|Text:Focusable Button__'
    output   = @parser.render(markdown)
    assert_equal "<div class='ui focusable button' tabindex='0'>Focusable Button</div>", output
  end

  def test_focusable_button_alternative
    markdown =
        '
> Focusable Button:
> Focusable Button
'
    output   = @parser.render(markdown)
    assert_equal "<div class='ui focusable button' tabindex='0'>Focusable Button</div>", output
  end

  def test_focusable_button_without_klass
    markdown = '__Focusable Button|Text:Focusable Button__'
    output   = @parser.render(markdown)
    assert_equal "<div class='ui focusable button' tabindex='0'>Focusable Button</div>", output
  end

  def test_focusable_class_button
    markdown = '__Button.Focusable|Text:Focusable Button|Focusable__'
    output   = @parser.render(markdown)
    assert_equal "<div id='focusable' class='ui focusable button' tabindex='0'>Focusable Button</div>", output
  end

  def test_ordinality
    markdown1 = '__Primary Button|Text:Save|Primary__'
    markdown2 = '__Button|Text:Discard__'
    output1   = @parser.render(markdown1)
    output2   = @parser.render(markdown2)
    assert_equal "<button id='primary' class='ui primary button'>Save</button>", output1
    assert_equal "<button class='ui button'>Discard</button>", output2

    markdown3 = '__Secondary Button|Text:Save|Secondary__'
    markdown4 = '__Button|Text:Discard__'
    output3   = @parser.render(markdown3)
    output4   = @parser.render(markdown4)
    assert_equal "<button id='secondary' class='ui secondary button'>Save</button>", output3
    assert_equal "<button class='ui button'>Discard</button>", output4
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
    assert_equal "<button class='ui primary button'>Save</button>", output1
    assert_equal "<button class='ui button'>Discard</button>", output2

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
    assert_equal "<button class='ui secondary button'>Save</button>", output3
    assert_equal "<button class='ui button'>Discard</button>", output4
  end

  def test_animated
    markdown = '__Animated Button|Text:Next;Icon:Right Arrow__'
    output   = @parser.render(markdown)
    assert_equal "<div class='ui animated button'>\n  <div class='visible content'>Next</div>\n  <div class='hidden content'><i class='right arrow icon'></i></div>\n</div>", output
  end

  def test_animated_alternative
    markdown =
        '
> Animated Button:
> Next;
> _Right Arrow Icon_
'

    output = @parser.render(markdown)
    assert_equal "<div class='ui animated button'>\n  <div class='visible content'>Next</div>\n  <div class='hidden content'><i class='right arrow icon'></i></div>\n</div>", output
  end

  def test_animated_alternative_versa
    markdown =
        '
> Animated Button:
> _Right Arrow Icon_;
> Next
'

    output = @parser.render(markdown)
    assert_equal "<div class='ui animated button'>\n  <div class='visible content'><i class='right arrow icon'></i></div>\n  <div class='hidden content'>Next</div>\n</div>", output
  end

  def test_animated_with_klass
    markdown = '__Animated Klass Button|Text:Next;Icon:Right Arrow|This is an ID__'
    output   = @parser.render(markdown)
    assert_equal "<div id='this-is-an-id' class='ui animated klass button'>\n  <div class='visible content'>Next</div>\n  <div class='hidden content'><i class='right arrow icon'></i></div>\n</div>", output
  end

  def test_vertical_animated
    markdown = '__Vertical Animated Button|Icon:Shop;Text:Shop|Vertical__'
    output   = @parser.render(markdown)
    assert_equal "<div id='vertical' class='ui vertical animated button'>\n  <div class='visible content'><i class='shop icon'></i></div>\n  <div class='hidden content'>Shop</div>\n</div>", output
  end

  def test_animated_fade
    markdown = '__Fade Animated Button|Text:Sign-up for a Pro account;Text:$12.99 a month|Fade__'
    output   = @parser.render(markdown)
    assert_equal "<div id='fade' class='ui fade animated button'>\n  <div class='visible content'>Sign-up for a Pro account</div>\n  <div class='hidden content'>$12.99 a month</div>\n</div>", output
  end

  def test_animated_fade_without_animated_mode_defined
    markdown = '__Fade Animated Button|Text:Sign-up for a Pro account:Visible Content,Text:$12.99 a month:Hidden Content|Fade Animated__'
    output   = @parser.render(markdown)
    assert_equal "<div id='fade-animated' class='ui fade animated button'>\n  <div class='visible content'>Sign-up for a Pro account</div>\n  <div class='hidden content'>$12.99 a month</div>\n</div>", output
  end

  def test_icon_button
    markdown = '__Icon Button|Icon:Cloud__'
    output   = @parser.render(markdown)
    assert_equal "<button class='ui icon button'><i class='cloud icon'></i></button>", output
  end

  def test_icon_button_alternative
    markdown =
        '
> Icon Button:
> _Cloud Icon_
'
    output   = @parser.render(markdown)
    assert_equal "<button class='ui icon button'><i class='cloud icon'></i></button>", output
  end

  def test_multiple_elements_in_a_button
    markdown = '__Button|Icon:Cloud:Fluffy,Text:Literal Text,Icon:Cloud,Text:Cloud:Fluffy__'
    output   = @parser.render(markdown)
    assert_equal "<button class='ui button'><i class='cloud fluffy icon'></i>Literal Text<i class='cloud icon'></i>\n  <div class='fluffy'>Cloud</div>\n</button>", output
  end

  def test_icon_button_without_icon_mode_defined
    markdown = '__Icon Button|Icon:Cloud|Icon__'
    output   = @parser.render(markdown)
    assert_equal "<button id='icon' class='ui icon button'><i class='cloud icon'></i></button>", output
  end

  def test_labeled_icon_button
    markdown = '__Labeled Icon Button|Icon:Pause,Text:Pause__'
    output   = @parser.render(markdown)
    assert_equal "<button class='ui labeled icon button'><i class='pause icon'></i>Pause</button>", output
  end

  def test_labeled_icon_button_with_klass
    markdown = '__Right Labeled Icon Button|Icon:Right Arrow,Text:Next|Right__'
    output   = @parser.render(markdown)
    assert_equal "<button id='right' class='ui right labeled icon button'><i class='right arrow icon'></i>Next</button>", output
  end

  def test_labeled_icon_button_without_icon_mode_defined
    markdown = '__Labeled Icon Button|Icon:Pause,Text:Pause|Labeled Icon__'
    output   = @parser.render(markdown)
    assert_equal "<button id='labeled-icon' class='ui labeled icon button'><i class='pause icon'></i>Pause</button>", output
  end

  def test_basic_icon
    markdown = '__Basic Button|Icon:User,Text:Add Friend__'
    output   = @parser.render(markdown)
    assert_equal "<button class='ui basic button'><i class='user icon'></i>Add Friend</button>", output
  end

  def test_basic_icon_without_basic_mode_defined
    markdown = '__Basic Button|Icon:User,Text:Add Friend|Basic__'
    output   = @parser.render(markdown)
    assert_equal "<button id='basic' class='ui basic button'><i class='user icon'></i>Add Friend</button>", output
  end

  def test_custom_button
    markdown = '__Very Cool Button|Icon:User,Text:Add Friend__'
    output   = @parser.render(markdown)
    assert_equal "<button class='ui very cool button'><i class='user icon'></i>Add Friend</button>", output
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
    output   = @parser.render(markdown)
    assert_equal "<section class='ui inverted segment'><button id='inverted' class='ui inverted button'>Standard</button>\n  <button id='inverted-black' class='ui inverted black button'>Black</button>\n  <button id='inverted-yellow' class='ui inverted yellow button'>Yellow</button>\n  <button id='inverted-green' class='ui inverted green button'>Green</button>\n  <button id='inverted-blue' class='ui inverted blue button'>Blue</button>\n  <button id='inverted-orange' class='ui inverted orange button'>Orange</button>\n  <button id='inverted-purple' class='ui inverted purple button'>Purple</button>\n  <button id='inverted-pink' class='ui inverted pink button'>Pink</button>\n  <button id='inverted-red' class='ui inverted red button'>Red</button>\n  <button id='inverted-teal' class='ui inverted teal button'>Teal</button></section>", output
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
    output   = @parser.render(markdown)
    assert_equal "<section class='ui inverted segment'><button id='basic' class='ui basic button'>Basic</button>\n  <button id='basic-black' class='ui basic black button'>Black Basic</button>\n  <button id='basic-yellow' class='ui basic yellow button'>Yellow Basic</button>\n  <button id='basic-green' class='ui basic green button'>Green Basic</button>\n  <button id='basic-blue' class='ui basic blue button'>Blue Basic</button>\n  <button id='basic-orange' class='ui basic orange button'>Orange Basic</button>\n  <button id='basic-purple' class='ui basic purple button'>Purple Basic</button>\n  <button id='basic-pink' class='ui basic pink button'>Pink Basic</button>\n  <button id='basic-red' class='ui basic red button'>Red Basic</button>\n  <button id='basic-teal' class='ui basic teal button'>Teal Basic</button></section>", output
  end

  def test_group_buttons
    markdown =
        '
> Buttons:
> __Standard Button|Text: One|Standard__
> __Standard Button|Text: Two|Standard__
> __Standard Button|Text: Three|Standard__
'
    output   = @parser.render(markdown)
    assert_equal "<div class='ui buttons'><button id='standard' class='ui standard button'>One</button>\n  <button id='standard' class='ui standard button'>Two</button>\n  <button id='standard' class='ui standard button'>Three</button></div>", output
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
    assert_equal "<div class='ui icon buttons'><button class='ui button'><i class='align left icon'></i></button>\n  <button class='ui button'><i class='align center icon'></i></button>\n  <button class='ui button'><i class='align right icon'></i></button>\n  <button class='ui button'><i class='align justify icon'></i></button></div><p></p><div class='ui icon buttons'><button class='ui button'><i class='bold icon'></i></button>\n  <button class='ui button'><i class='underline icon'></i></button>\n  <button class='ui button'><i class='text width icon'></i></button></div>", output
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
    assert_equal "<div class='ui icon buttons'><button class='ui button'>Cancel</button>\n  <div class='or'></div>\n  <button id='positive' class='ui positive button'>Save</button></div>", output
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
    assert_equal "<div class='ui icon buttons'><button class='ui button'>un</button>\n  <div class='or' data-text='ou'></div>\n  <button id='positive' class='ui positive button'>deux</button></div>", output
  end

  def test_active_state
    markdown = ' __Active Button|Icon:User,Text:Follow__ '

    output = @parser.render(markdown)
    assert_equal "<button class='ui active button'><i class='user icon'></i>Follow</button>", output
  end

  def test_disabled_state
    markdown = ' __Disabled Button|Icon:User,Text:Followed__ '

    output = @parser.render(markdown)
    assert_equal "<button class='ui disabled button'><i class='user icon'></i>Followed</button>", output
  end

  def test_loading_state
    markdown = '
__Loading Button|Loading__
__Basic Loading Button|Loading__
__Primary Loading Button|Loading__
__Secondary Loading Button|Loading__
'

    output = @parser.render(markdown)
    assert_equal "<button class='ui loading button'>Loading</button>\n<button class='ui basic loading button'>Loading</button>\n<button class='ui primary loading button'>Loading</button>\n<button class='ui secondary loading button'>Loading</button>", output
  end

  def test_social_variation
    markdown = '
__Facebook Button|Icon:Facebook, Facebook__
__Twitter Button|Icon:Twitter, Twitter__
__Google Plus Button|Icon:Google Plus, Google Plus__
__VK Button|Icon:VK, VK__
__LinkedIn Button|Icon:LinkedIn, LinkedIn__
__Instagram Button|Icon:Instagram, Instagram__
__YouTube Button|Icon:YouTube, YouTube__
'

    output = @parser.render(markdown)
    assert_equal "<button class='ui facebook button'><i class='facebook icon'></i>Facebook</button>\n<button class='ui twitter button'><i class='twitter icon'></i>Twitter</button>\n<button class='ui google plus button'><i class='google plus icon'></i>Google Plus</button>\n<button class='ui vk button'><i class='vk icon'></i>VK</button>\n<button class='ui linkedin button'><i class='linkedin icon'></i>LinkedIn</button>\n<button class='ui instagram button'><i class='instagram icon'></i>Instagram</button>\n<button class='ui youtube button'><i class='youtube icon'></i>YouTube</button>", output
  end

  def test_size_variation
    markdown = '
__Mini Button|Mini__
__Tiny Button|Tiny__
__Small Button|Small__
__Medium Button|Medium__
__Large Button|Large__
__Big Button|Big__
__Huge Button|Huge__
__Massive Button|Massive__
'
    output   = @parser.render(markdown)
    assert_equal "<button class='ui mini button'>Mini</button>\n<button class='ui tiny button'>Tiny</button>\n<button class='ui small button'>Small</button>\n<button class='ui medium button'>Medium</button>\n<button class='ui large button'>Large</button>\n<button class='ui big button'>Big</button>\n<button class='ui huge button'>Huge</button>\n<button class='ui massive button'>Massive</button>", output
  end

  def test_colored_variation
    markdown = '
__Red Button|Red__
__Orange Button|Orange__
__Yellow Button|Yellow__
__Olive Button|Olive__
__Green Button|Green__
__Teal Button|Teal__
__Blue Button|Blue__
__Violet Button|Violet__
__Purple Button|Purple__
__Pink Button|Pink__
__Brown Button|Brown__
__Grey Button|Grey__
__Black Button|Black__
'
    output   = @parser.render(markdown)
    assert_equal "<button class='ui red button'>Red</button>\n<button class='ui orange button'>Orange</button>\n<button class='ui yellow button'>Yellow</button>\n<button class='ui olive button'>Olive</button>\n<button class='ui green button'>Green</button>\n<button class='ui teal button'>Teal</button>\n<button class='ui blue button'>Blue</button>\n<button class='ui violet button'>Violet</button>\n<button class='ui purple button'>Purple</button>\n<button class='ui pink button'>Pink</button>\n<button class='ui brown button'>Brown</button>\n<button class='ui grey button'>Grey</button>\n<button class='ui black button'>Black</button>", output
  end

  def test_compact_variation
    markdown = '
__Compact Button|Hold__
__Compact Icon Button|Icon:Pause__
__Compact Labeled Icon Button|Icon:Pause, Pause__
'
    output   = @parser.render(markdown)
    assert_equal "<button class='ui compact button'>Hold</button>\n<button class='ui compact icon button'><i class='pause icon'></i></button>\n<button class='ui compact labeled icon button'><i class='pause icon'></i>Pause</button>", output
  end

  def test_positive_variation
    markdown = '
__Positive Button|Positive Button__
__Negative Button|Negative Button__
'
    output   = @parser.render(markdown)
    assert_equal "<button class='ui positive button'>Positive Button</button>\n<button class='ui negative button'>Negative Button</button>", output
  end

  def test_negative_variation
    markdown = '
__Negative Button|Negative Button__
'
    output   = @parser.render(markdown)
    assert_equal "<button class='ui negative button'>Negative Button</button>", output
  end

  def test_fluid_variation
    markdown = '
__Fluid Button|Fluid Button__
'
    output   = @parser.render(markdown)
    assert_equal "<button class='ui fluid button'>Fluid Button</button>", output
  end

  def test_circular_variation
    markdown = '
__Circular Icon Button|Icon:Settings__
'
    output   = @parser.render(markdown)
    assert_equal "<button class='ui circular icon button'><i class='settings icon'></i></button>", output
  end

  def test_vertically_attached_variation
    markdown = '
__Top Attached Focusable Button|Top__

> Attached Segment:
> " "

__Bottom Attached Focusable Button|Bottom__
'
    output   = @parser.render(markdown)
    assert_equal "<div class='ui top attached focusable button' tabindex='0'>Top</div><section class='ui attached segment'>\n  <p></p>\n</section><div class='ui bottom attached focusable button' tabindex='0'>Bottom</div>", output
  end

  def test_vertically_attached_variation_2
    markdown = '
> Two Top Attached Buttons:
> __Button|One__
> __Button|Two__

<!-- -->

> Attached Segment:
> " "

<!-- -->

> Two Bottom Attached Buttons:
> __Button|One__
> __Button|Two__
'

    output = @parser.render(markdown)
    assert_equal "<div class='ui two top attached buttons'><button class='ui button'>One</button>\n  <button class='ui button'>Two</button></div>\n<!-- -->\n<section class='ui attached segment'>\n  <p></p>\n</section>\n<!-- -->\n<div class='ui two bottom attached buttons'><button class='ui button'>One</button>\n  <button class='ui button'>Two</button></div>", output
  end

  def test_vertical_buttons_group_variations
    markdown = '
> Vertical Buttons:
> __Button|Feed__
> __Button|Messages__
> __Button|Events__
> __Button|Photos__
'

    output = @parser.render(markdown)
    assert_equal "<div class='ui vertical buttons'><button class='ui button'>Feed</button>\n  <button class='ui button'>Messages</button>\n  <button class='ui button'>Events</button>\n  <button class='ui button'>Photos</button></div>", output
  end

  def test_icon_buttons_group_variations
    markdown = '
> Icon Buttons:
> __Button|Icon:Play__
> __Button|Icon:Pause__
> __Button|Icon:Shuffle__
'

    output = @parser.render(markdown)
    assert_equal "<div class='ui icon buttons'><button class='ui button'><i class='play icon'></i></button>\n  <button class='ui button'><i class='pause icon'></i></button>\n  <button class='ui button'><i class='shuffle icon'></i></button></div>", output
  end

  def test_labeled_icon_buttons_group_variations
    markdown = '
> Vertical Labeled Icon Buttons:
> __Button|Icon:Pause, Pause__
> __Button|Icon:Play, Play__
> __Button|Icon:Shuffle, Shuffle__
'

    output = @parser.render(markdown)
    assert_equal "<div class='ui vertical labeled icon buttons'><button class='ui button'><i class='pause icon'></i>Pause</button>\n  <button class='ui button'><i class='play icon'></i>Play</button>\n  <button class='ui button'><i class='shuffle icon'></i>Shuffle</button></div>", output
  end

  def test_mixed_group_variations
    markdown = '
> Buttons:
> __Labeled Icon Button|Icon:Left Chevron, Back__
> __Button|Icon:Stop, Stop__
> __Labeled Right Icon Button|Icon:Right Chevron, Forward__
'

    output = @parser.render(markdown)
    assert_equal "<div class='ui buttons'><button class='ui labeled icon button'><i class='left chevron icon'></i>Back</button>\n  <button class='ui button'><i class='stop icon'></i>Stop</button>\n  <button class='ui labeled right icon button'><i class='right chevron icon'></i>Forward</button></div>", output
  end

  def test_equal_width_group_variations
    markdown = '
> Buttons:
> __Button|Overview__
> __Button|Specs__
> __Button|Warranty__
> __Button|Reviews__
> __Button|Support__

<!-- -->

> Three Buttons:
> __Button|Overview__
> __Button|Specs__
> __Button|Support__
'

    output = @parser.render(markdown)
    assert_equal "<div class='ui buttons'><button class='ui button'>Overview</button>\n  <button class='ui button'>Specs</button>\n  <button class='ui button'>Warranty</button>\n  <button class='ui button'>Reviews</button>\n  <button class='ui button'>Support</button></div>\n<!-- -->\n<div class='ui three buttons'><button class='ui button'>Overview</button>\n  <button class='ui button'>Specs</button>\n  <button class='ui button'>Support</button></div>", output
  end

  def test_colored_group_variations
    markdown = '
> Blue Buttons:
> __Button|One__
> __Button|Two__
> __Button|Three__
'

    output = @parser.render(markdown)
    assert_equal "<div class='ui blue buttons'><button class='ui button'>One</button>\n  <button class='ui button'>Two</button>\n  <button class='ui button'>Three</button></div>", output
  end

  def test_basic_buttons_group_variations
    markdown = '
> Basic Buttons:
> __Button|One__
> __Button|Two__
> __Button|Three__
___
> Vertical Basic Buttons:
> __Button|One__
> __Button|Two__
> __Button|Three__
'

    output = @parser.render(markdown)
    assert_equal "<div class='ui basic buttons'><button class='ui button'>One</button>\n  <button class='ui button'>Two</button>\n  <button class='ui button'>Three</button>\n  <div class='ui divider'></div>\n  Vertical Basic Buttons</div>", output
  end

  def test_sizes_group_variations
    markdown = '
> Large Buttons:
> __Button|One__
> __Button|Two__
> __Button|Three__
'

    output = @parser.render(markdown)
    assert_equal "<div class='ui large buttons'><button class='ui button'>One</button>\n  <button class='ui button'>Two</button>\n  <button class='ui button'>Three</button></div>", output
  end

  def test_sizes_group_variations_2
    markdown = '
> Small Basic Icon Buttons:
> __Button|Icon:File__
> __Button|Icon:Save__
> __Button|Icon:Upload__
> __Button|Icon:Download__
'
    output   = @parser.render(markdown)
    assert_equal "<div class='ui small basic icon buttons'><button class='ui button'><i class='file icon'></i></button>\n  <button class='ui button'><i class='save icon'></i></button>\n  <button class='ui button'><i class='upload icon'></i></button>\n  <button class='ui button'><i class='download icon'></i></button></div>", output
  end

  def test_sizes_group_variations_3
    markdown = '
> Large Buttons:
> __Button|One__
> __Div Tag||Or__
> __Button|Two__
'
    output   = @parser.render(markdown)
    assert_equal "<div class='ui large buttons'><button class='ui button'>One</button>\n  <div class='or'></div>\n  <button class='ui button'>Two</button></div>", output
  end
end
