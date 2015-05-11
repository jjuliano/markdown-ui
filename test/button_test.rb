# coding: UTF-8
require_relative 'test_helper'

class ButtonTest < Redcarpet::TestCase
  def setup
    @parser = Redcarpet::Markdown.new(MarkdownUI::Renderer, quote: true)
  end

  def test_standard_button
    markdown = "__Standard Button|Text:Follow|Klass__"
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui klass button\">Follow</div>\n", output
  end

  def test_standard_button_without_standard_mode_defined
    markdown = "__Button|Text:Follow|Klass__"
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui klass button\">Follow</div>\n", output
  end

  def test_standard_button_without_klass
    markdown = "__Button|Text:Follow__"
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui button\">Follow</div>\n", output
  end

  def test_focusable_button
    markdown = "__Focusable Button|Text:Focusable Button|Focusable__"
    output = @parser.render(markdown)
    assert_equal "<button class=\"ui focusable button\">Focusable Button</button>\n", output
  end

  def test_focusable_button_without_klass
    markdown = "__Focusable Button|Text:Focusable Button__"
    output = @parser.render(markdown)
    assert_equal "<button class=\"ui button\">Focusable Button</button>\n", output
  end

  def test_focusable_class_button
    markdown = "__Standard Button|Text:Focusable Button|Focusable__"
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui focusable button\">Focusable Button</div>\n", output
  end

  def test_ordinality
    markdown1 = "__Standard Button|Text:Save|Primary__"
    markdown2 = "__Standard Button|Text:Discard__"
    output1 = @parser.render(markdown1)
    output2 = @parser.render(markdown2)
    assert_equal "<div class=\"ui primary button\">Save</div>\n", output1
    assert_equal "<div class=\"ui button\">Discard</div>\n", output2

    markdown3 = "__Standard Button|Text:Save|Secondary__"
    markdown4 = "__Standard Button|Text:Discard__"
    output3 = @parser.render(markdown3)
    output4 = @parser.render(markdown4)
    assert_equal "<div class=\"ui secondary button\">Save</div>\n", output3
    assert_equal "<div class=\"ui button\">Discard</div>\n", output4
  end

  def test_animated
    markdown = "__Animated Button|Text:Next;Icon:Right Arrow__"
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui animated button\"><div class=\"visible content\">Next</div><div class=\"hidden content\"><i class=\"right arrow icon\"></i></div></div>\n", output
  end

  def test_animated_with_klass
    markdown = "__Animated Button|Text:Next;Icon:Right Arrow|Klass__"
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui klass animated button\"><div class=\"visible content\">Next</div><div class=\"hidden content\"><i class=\"right arrow icon\"></i></div></div>\n", output
  end

  def test_vertical_animated
    markdown = "__Animated Button|Icon:Shop;Text:Shop|Vertical__"
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui vertical animated button\"><div class=\"visible content\"><i class=\"shop icon\"></i></div><div class=\"hidden content\">Shop</div></div>\n", output
  end

  def test_animated_fade
    markdown = "__Animated Button|Text:Sign-up for a Pro account;Text:$12.99 a month|Fade__"
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui fade animated button\"><div class=\"visible content\">Sign-up for a Pro account</div><div class=\"hidden content\">$12.99 a month</div></div>\n", output
  end

  def test_animated_fade_without_animated_mode_defined
    markdown = "__Button|Text:Sign-up for a Pro account:Visible Content,Text:$12.99 a month:Hidden Content|Fade Animated__"
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui fade animated button\"><div class=\"visible content\">Sign-up for a Pro account</div><div class=\"hidden content\">$12.99 a month</div></div>\n", output
  end

  def test_icon_button
    markdown = "__Icon Button|Icon:Cloud__"
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui icon button\"><i class=\"cloud icon\"></i></div>\n", output
  end

  def test_multiple_elements_in_a_button
    markdown = "__Button|Icon:Cloud:Fluffy,Text:Literal Text,Icon:Cloud,Text:Cloud:Fluffy__"
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui button\"><i class=\"cloud fluffy icon\"></i>Literal Text<i class=\"cloud icon\"></i><div class=\"fluffy\">Cloud</div></div>\n", output
  end

  def test_icon_button_without_icon_mode_defined
    markdown = "__Button|Icon:Cloud|Icon__"
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui icon button\"><i class=\"cloud icon\"></i></div>\n", output
  end

  def test_labeled_icon_button
    markdown = "__Labeled Icon Button|Icon:Pause,Text:Pause__"
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui labeled icon button\"><i class=\"pause icon\"></i>Pause</div>\n", output
  end

  def test_labeled_icon_button_with_klass
    markdown = "__Labeled Icon Button|Icon:Right Arrow,Text:Next|Right__"
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui right labeled icon button\"><i class=\"right arrow icon\"></i>Next</div>\n", output
  end

  def test_labeled_icon_button_without_icon_mode_defined
    markdown = "__Button|Icon:Pause,Text:Pause|Labeled Icon__"
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui labeled icon button\"><i class=\"pause icon\"></i>Pause</div>\n", output
  end

  def test_basic_icon
    markdown = "__Basic Button|Icon:User,Text:Add Friend__"
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui basic button\"><i class=\"user icon\"></i>Add Friend</div>\n", output
  end

  def test_basic_icon_without_basic_mode_defined
    markdown = "__Button|Icon:User,Text:Add Friend|Basic__"
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui basic button\"><i class=\"user icon\"></i>Add Friend</div>\n", output
  end

  def test_custom_button
    markdown = "__Very Cool Button|Icon:User,Text:Add Friend__"
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui very cool button\"><i class=\"user icon\"></i>Add Friend</div>\n", output
  end

end

# ## Inverted
# ### Inverted
#     >Inverted Segment:::
#     > __Button|Inverted|Text > Standard__
#     > __Button|Inverted Black|Text > Black__
#     > __Button|Inverted Yellow|Text > Yellow__
#     > __Button|Inverted Green|Text > Green__
#     > __Button|Inverted Blue|Text > Blue__
#     > __Button|Inverted Orange|Text > Orange__
#     > __Button|Inverted Purple|Text > Purple__
#     > __Button|Inverted Pink|Text > Pink__
#     > __Button|Inverted Red|Text > Red__
#     > __Button|Inverted Teal|Text > Teal__
#
#     <div class="ui inverted segment">
#       <div class="ui inverted button">Standard</div>
#       <div class="ui inverted black button">Black</div>
#       <div class="ui inverted yellow button">Yellow</div>
#       <div class="ui inverted green button">Green</div>
#       <div class="ui inverted blue button">Blue</div>
#       <div class="ui inverted orange button">Orange</div>
#       <div class="ui inverted purple button">Purple</div>
#       <div class="ui inverted pink button">Pink</div>
#       <div class="ui inverted red button">Red</div>
#       <div class="ui inverted teal button">Teal</div>
#     </div>
#
# ### Basic Inverted
#     > Inverted Segment:::
#     > __Button|Inverted Basic|Text > Basic__
#     > __Button|Inverted Black Basic|Text > Basic Black__
#     > __Button|Inverted Yellow Basic|Text > Basic Yellow__
#     > __Button|Inverted Green Basic|Text > Basic Green__
#     > __Button|Inverted Blue Basic|Text > Basic Blue__
#     > __Button|Inverted Orange Basic|Text > Basic Orange__
#     > __Button|Inverted Purple Basic|Text > Basic Purple__
#     > __Button|Inverted Pink Basic|Text > Basic Pink__
#     > __Button|Inverted Red Basic|Text > Basic Red__
#     > __Button|Inverted Teal Basic|Text > Basic Teal__
#
#     <div class="ui inverted segment">
#       <div class="ui inverted basic button">Basic</div>
#       <div class="ui inverted black basic button">Basic Black</div>
#       <div class="ui inverted yellow basic button">Basic Yellow</div>
#       <div class="ui inverted green basic button">Basic Green</div>
#       <div class="ui inverted blue basic button">Basic Blue</div>
#       <div class="ui inverted orange basic button">Basic Orange</div>
#       <div class="ui inverted purple basic button">Basic Purple</div>
#       <div class="ui inverted pink basic button">Basic Pink</div>
#       <div class="ui inverted red basic button">Basic Red</div>
#       <div class="ui inverted teal basic button">Basic Teal</div>
#     </div>
#
# ## Group
# ### Group
#     > Buttons:::
#     > __Button|Standard|Text > One__
#     > __Button|Standard|Text > Two__
#     > __Button|Standard|Text > Three__
#
#     <div class="ui buttons">
#       <div class="ui button">One</div>
#       <div class="ui button">Two</div>
#       <div class="ui button">Three</div>
#     </div>
#
# ### Conditionals
#     > Buttons:::
#     > __Button|Conditional|Text > Cancel|Or|Primary > Text > Save__
#
#     <div class="ui buttons">
#       <div class="ui button">Cancel</div>
#       <div class="or"></div>
#       <div class="ui positive button">Save</div>
#     </div>
#
# ### Data Text
#     > Buttons:::
#     > __Button|Conditional|Text > un|Data Text > Ou|Primary > Text > deux__
#
#     <div class="ui buttons">
#       <div class="ui button">un</div>
#       <div class="or" data-text="ou"></div>
#       <div class="ui positive button">deux</div>
#     </div>
#
