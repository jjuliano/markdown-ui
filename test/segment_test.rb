# coding: UTF-8
require_relative 'test_helper'

class SegmentTest < Redcarpet::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_segment
    markdown =
        '
> Segment:
> "Lorem Ipsum Dolor"
'

    output = @parser.parse(markdown)
    assert_equal \
'<section class="ui segment"><p>Lorem Ipsum Dolor</p></section>
', output
  end

  def test_segment_with_class_and_id
    markdown = '__.custom-segment#info-section Segment|Custom segment content__'
    output = @parser.parse(markdown)
    assert_equal \
'<section class="ui segment custom-segment" id="info-section"><p>Custom segment content</p></section>
', output
  end

  def test_segment_with_multiple_classes
    markdown = '__.segment-primary.segment-large#primary-seg Segment|Primary large segment__'
    output = @parser.parse(markdown)
    assert_equal \
'<section class="ui segment segment-primary segment-large" id="primary-seg"><p>Primary large segment</p></section>
', output
  end

  def test_vertical_segment
    markdown =
        '
> Vertical Segment:
> "Lorem Ipsum Dolor"

" "

> Vertical Segment:
> "Lorem Ipsum Dolor"

" "

> Vertical Segment:
> "Lorem Ipsum Dolor"
'

    output = @parser.parse(markdown)
    assert_equal \
'<section class="ui vertical segment"><p>Lorem Ipsum Dolor</p></section>

<p></p>
<section class="ui vertical segment"><p>Lorem Ipsum Dolor</p></section>

<p></p>
<section class="ui vertical segment"><p>Lorem Ipsum Dolor</p></section>
', output
  end

  def test_horizontal_segment
    markdown =
        '
> Horizontal Segment:
> " "

" "

> Horizontal Segment:
> " "

" "

> Horizontal Segment:
> " "
'

    output = @parser.parse(markdown)
    assert_equal \
'<section class="ui horizontal segment"><p></p></section>

<p></p>
<section class="ui horizontal segment"><p></p></section>

<p></p>
<section class="ui horizontal segment"><p></p></section>
', output
  end

  def test_stacked_segment
    markdown =
        '
> Stacked Segment:
> "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo."
'
    output   = @parser.parse(markdown)
    assert_equal \
'<section class="ui stacked segment"><p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.</p></section>
', output
  end

  def test_piled_segment
    markdown =
        '
> Piled Segment:
> #### A Header
> "Te eum doming eirmod, nominati pertinacia argumentum ad his. Ex eam alia facete scriptorem, est autem aliquip detraxit at. Usu ocurreret referrentur at, cu epicurei appellantur vix. Cum ea laoreet recteque electram, eos choro alterum definiebas in. Vim dolorum definiebas an. Mei ex natum rebum iisque."
> "Audiam quaerendum eu sea, pro omittam definiebas ex. Te est latine definitiones. Quot wisi nulla ex duo. Vis sint solet expetenda ne, his te phaedrum referrentur consectetuer. Id vix fabulas oporteat, ei quo vide phaedrum, vim vivendum maiestatis in."
> "Eu quo homero blandit intellegebat. Incorrupte consequuntur mei id. Mei ut facer dolores adolescens, no illum aperiri quo, usu odio brute at. Qui te porro electram, ea dico facete utroque quo. Populo quodsi te eam, wisi everti eos ex, eum elitr altera utamur at. Quodsi convenire mnesarchum eu per, quas minimum postulant per id."
'
    output   = @parser.parse(markdown)
    assert_equal \
'<section class="ui piled segment"><h4 class="ui header">A Header</h4>
<p>Te eum doming eirmod, nominati pertinacia argumentum ad his. Ex eam alia facete scriptorem, est autem aliquip detraxit at. Usu ocurreret referrentur at, cu epicurei appellantur vix. Cum ea laoreet recteque electram, eos choro alterum definiebas in. Vim dolorum definiebas an. Mei ex natum rebum iisque.</p>
<p>Audiam quaerendum eu sea, pro omittam definiebas ex. Te est latine definitiones. Quot wisi nulla ex duo. Vis sint solet expetenda ne, his te phaedrum referrentur consectetuer. Id vix fabulas oporteat, ei quo vide phaedrum, vim vivendum maiestatis in.</p>
<p>Eu quo homero blandit intellegebat. Incorrupte consequuntur mei id. Mei ut facer dolores adolescens, no illum aperiri quo, usu odio brute at. Qui te porro electram, ea dico facete utroque quo. Populo quodsi te eam, wisi everti eos ex, eum elitr altera utamur at. Quodsi convenire mnesarchum eu per, quas minimum postulant per id.</p></section>
', output
  end

  def test_disabled_state
    markdown =
        '
> Disabled Segment:
> " "
'
    output   = @parser.parse(markdown)
    assert_equal \
'<section class="ui disabled segment"><p></p></section>
', output
  end

  def test_disabled_state_on_all_types
    markdown =
        '
> Disabled Segment:
> "Lorem Ipsum Dolor"
'
    output   = @parser.parse(markdown)
    assert_equal \
'<section class="ui disabled segment"><p>Lorem Ipsum Dolor</p></section>
', output

    markdown =
        '
> Vertical Disabled Segment:
> "Lorem Ipsum Dolor"

" "

> Vertical Disabled Segment:
> "Lorem Ipsum Dolor"

" "

> Vertical Disabled Segment:
> "Lorem Ipsum Dolor"
'

    output = @parser.parse(markdown)
    assert_equal \
'<section class="ui vertical disabled segment"><p>Lorem Ipsum Dolor</p></section>

<p></p>
<section class="ui vertical disabled segment"><p>Lorem Ipsum Dolor</p></section>

<p></p>
<section class="ui vertical disabled segment"><p>Lorem Ipsum Dolor</p></section>
', output

    markdown =
        '
> Horizontal Disabled Segment:
> " "

" "

> Horizontal Disabled Segment:
> " "

" "

> Horizontal Disabled Segment:
> " "
'

    output = @parser.parse(markdown)
    assert_equal \
'<section class="ui horizontal disabled segment"><p></p></section>

<p></p>
<section class="ui horizontal disabled segment"><p></p></section>

<p></p>
<section class="ui horizontal disabled segment"><p></p></section>
', output

    markdown =
        '
> Stacked Disabled Segment:
> "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo."
'
    output   = @parser.parse(markdown)
    assert_equal \
'<section class="ui stacked disabled segment"><p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.</p></section>
', output

    markdown =
        '
> Piled Disabled Segment:
> #### A Header
> "Te eum doming eirmod, nominati pertinacia argumentum ad his. Ex eam alia facete scriptorem, est autem aliquip detraxit at. Usu ocurreret referrentur at, cu epicurei appellantur vix. Cum ea laoreet recteque electram, eos choro alterum definiebas in. Vim dolorum definiebas an. Mei ex natum rebum iisque."
> "Audiam quaerendum eu sea, pro omittam definiebas ex. Te est latine definitiones. Quot wisi nulla ex duo. Vis sint solet expetenda ne, his te phaedrum referrentur consectetuer. Id vix fabulas oporteat, ei quo vide phaedrum, vim vivendum maiestatis in."
> "Eu quo homero blandit intellegebat. Incorrupte consequuntur mei id. Mei ut facer dolores adolescens, no illum aperiri quo, usu odio brute at. Qui te porro electram, ea dico facete utroque quo. Populo quodsi te eam, wisi everti eos ex, eum elitr altera utamur at. Quodsi convenire mnesarchum eu per, quas minimum postulant per id."
'
    output   = @parser.parse(markdown)
    assert_equal \
'<section class="ui piled disabled segment"><h4 class="ui header">A Header</h4><p>Te eum doming eirmod, nominati pertinacia argumentum ad his. Ex eam alia facete scriptorem, est autem aliquip detraxit at. Usu ocurreret referrentur at, cu epicurei appellantur vix. Cum ea laoreet recteque electram, eos choro alterum definiebas in. Vim dolorum definiebas an. Mei ex natum rebum iisque.</p><p>Audiam quaerendum eu sea, pro omittam definiebas ex. Te est latine definitiones. Quot wisi nulla ex duo. Vis sint solet expetenda ne, his te phaedrum referrentur consectetuer. Id vix fabulas oporteat, ei quo vide phaedrum, vim vivendum maiestatis in.</p><p>Eu quo homero blandit intellegebat. Incorrupte consequuntur mei id. Mei ut facer dolores adolescens, no illum aperiri quo, usu odio brute at. Qui te porro electram, ea dico facete utroque quo. Populo quodsi te eam, wisi everti eos ex, eum elitr altera utamur at. Quodsi convenire mnesarchum eu per, quas minimum postulant per id.</p></section>
', output

  end

  def test_loading_state
    markdown =
        '
> Loading Segment:
> " "
'
    output   = @parser.parse(markdown)
    assert_equal \
'<section class="ui loading segment"><p></p></section>
', output
  end

  def test_loading_state_on_all_types
    markdown =
        '
> Loading Segment:
> "Lorem Ipsum Dolor"
'
    output   = @parser.parse(markdown)
    assert_equal \
'<section class="ui loading segment"><p>Lorem Ipsum Dolor</p></section>
', output

    markdown =
        '
> Vertical Loading Segment:
> "Lorem Ipsum Dolor"

" "

> Vertical Loading Segment:
> "Lorem Ipsum Dolor"

" "

> Vertical Loading Segment:
> "Lorem Ipsum Dolor"
'

    output = @parser.parse(markdown)
    assert_equal \
'<section class="ui vertical loading segment"><p>Lorem Ipsum Dolor</p></section>

<p></p>
<section class="ui vertical loading segment"><p>Lorem Ipsum Dolor</p></section>

<p></p>
<section class="ui vertical loading segment"><p>Lorem Ipsum Dolor</p></section>
', output

    markdown =
        '
> Horizontal Loading Segment:
> " "

" "

> Horizontal Loading Segment:
> " "

" "

> Horizontal Loading Segment:
> " "
'

    output = @parser.parse(markdown)
    assert_equal \
'<section class="ui horizontal loading segment">
  <p></p>
</section>

<p></p>
<section class="ui horizontal loading segment">
  <p></p>
</section>

<p></p>
<section class="ui horizontal loading segment">
  <p></p>
</section>
', output

    markdown =
        '
> Stacked Loading Segment:
> "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo."
'
    output   = @parser.parse(markdown)
    assert_equal \
'<section class="ui stacked loading segment">
  <p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.</p>
</section>
', output

    markdown =
        '
> Piled Loading Segment:
> #### A Header
> "Te eum doming eirmod, nominati pertinacia argumentum ad his. Ex eam alia facete scriptorem, est autem aliquip detraxit at. Usu ocurreret referrentur at, cu epicurei appellantur vix. Cum ea laoreet recteque electram, eos choro alterum definiebas in. Vim dolorum definiebas an. Mei ex natum rebum iisque."
> "Audiam quaerendum eu sea, pro omittam definiebas ex. Te est latine definitiones. Quot wisi nulla ex duo. Vis sint solet expetenda ne, his te phaedrum referrentur consectetuer. Id vix fabulas oporteat, ei quo vide phaedrum, vim vivendum maiestatis in."
> "Eu quo homero blandit intellegebat. Incorrupte consequuntur mei id. Mei ut facer dolores adolescens, no illum aperiri quo, usu odio brute at. Qui te porro electram, ea dico facete utroque quo. Populo quodsi te eam, wisi everti eos ex, eum elitr altera utamur at. Quodsi convenire mnesarchum eu per, quas minimum postulant per id."
'
    output   = @parser.parse(markdown)
    assert_equal \
'<section class="ui piled loading segment">
  <h4 class="ui header">A Header</h4>
  <p>Te eum doming eirmod, nominati pertinacia argumentum ad his. Ex eam alia facete scriptorem, est autem aliquip detraxit at. Usu ocurreret referrentur at, cu epicurei appellantur vix. Cum ea laoreet recteque electram, eos choro alterum definiebas in. Vim dolorum definiebas an. Mei ex natum rebum iisque.</p>
  <p>Audiam quaerendum eu sea, pro omittam definiebas ex. Te est latine definitiones. Quot wisi nulla ex duo. Vis sint solet expetenda ne, his te phaedrum referrentur consectetuer. Id vix fabulas oporteat, ei quo vide phaedrum, vim vivendum maiestatis in.</p>
  <p>Eu quo homero blandit intellegebat. Incorrupte consequuntur mei id. Mei ut facer dolores adolescens, no illum aperiri quo, usu odio brute at. Qui te porro electram, ea dico facete utroque quo. Populo quodsi te eam, wisi everti eos ex, eum elitr altera utamur at. Quodsi convenire mnesarchum eu per, quas minimum postulant per id.</p>
</section>
', output

  end

  def test_inverted_variation
    markdown =
        '
> Inverted Segment:
> "I\'m here to tell you something, and you will probably read me first."
'
    output   = @parser.parse(markdown)
    assert_equal \
'<section class="ui inverted segment"><p>I\'m here to tell you something, and you will probably read me first.</p></section>
', output
  end

  def test_attached_variation
    markdown =
        '
> Top Attached Segment:
> "This segment is on top"

" "

> Attached Segment:
> "This segment is attached on both sides"

" "

> Bottom Attached Segment:
> "This segment is on bottom"
'
    output   = @parser.parse(markdown)
    assert_equal \
'<section class="ui top attached segment"><p>This segment is on top</p></section>
<p></p><section class="ui attached segment"><p>This segment is attached on both sides</p></section>
<p></p><section class="ui bottom attached segment"><p>This segment is on bottom</p></section>
', output
  end

  def test_attached_variation_2
    markdown =
        '
##### Dogs:Top Attached
> Attached Segment:
> "Dogs are one type of animal"

" "

##### Cats:Attached
> Attached Segment:
> "Cats are thought of as being related to dogs, but only humans think this."

" "

##### Lions:Attached
> Attached Segment:
> "Humans don\'t think of lions as being like cats, but they are."

" "

__Warning Message Bottom Attached|Icon:Warning,Text:You\'ve reached the end of this content segment\!__
'
    output   = @parser.parse(markdown)
    assert_equal \
"<h5 class=\"ui top attached header\">Dogs</h5><section class=\"ui attached segment\"><p>Dogs are one type of animal</p></section>\n<p></p><h5 class=\"ui attached header\">Cats</h5><section class=\"ui attached segment\"><p>Cats are thought of as being related to dogs, but only humans think this.</p></section>\n<p></p><h5 class=\"ui attached header\">Lions</h5><section class=\"ui attached segment\"><p>Humans don't think of lions as being like cats, but they are.</p></section>\n<p></p><div class=\"ui warning bottom attached message\"><i class=\"warning icon\"></i>You've reached the end of this content segment!</div>\n", output
  end

  def test_attached_variation_2_alternative
    markdown =
        '
##### Dogs:Top Attached
> Attached Segment:
> "Dogs are one type of animal"

" "

##### Cats:Attached
> Attached Segment:
> "Cats are thought of as being related to dogs, but only humans think this."

" "

##### Lions:Attached
> Attached Segment:
> "Humans don\'t think of lions as being like cats, but they are."

" "

> Bottom Attached Warning Message:
> _Warning Icon_
> You\'ve reached the end of this content segment\!
'
    output   = @parser.parse(markdown)
    assert_equal \
"<h5 class=\"ui top attached header\">Dogs</h5><section class=\"ui attached segment\"><p>Dogs are one type of animal</p></section>\n<p></p><h5 class=\"ui attached header\">Cats</h5><section class=\"ui attached segment\"><p>Cats are thought of as being related to dogs, but only humans think this.</p></section>\n<p></p><h5 class=\"ui attached header\">Lions</h5><section class=\"ui attached segment\"><p>Humans don't think of lions as being like cats, but they are.</p></section>\n<p></p><div class=\"ui bottom attached warning message\"><i class=\"warning icon\"></i>\nYou've reached the end of this content segment!</div>\n", output
  end

  def test_padded
    markdown =
        '
> Padded Segment:
> " "
'

    output = @parser.parse(markdown)
    assert_equal \
'<section class="ui padded segment"><p></p></section>
', output
  end


end
