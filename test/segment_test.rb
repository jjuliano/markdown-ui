# coding: UTF-8
require_relative 'test_helper'

class SegmentTest < Redcarpet::TestCase
  def setup
    @parser = Redcarpet::Markdown.new(MarkdownUI::Renderer, quote: true)
  end

  def test_segment
    markdown = "> Segment:\n> \"Lorem Ipsum Dolor\""
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui segment\">\n<p>Lorem Ipsum Dolor</p></div>\n", output
  end

  def test_vertical_segment
    markdown =
<<-EOS
> Vertical Segment:
> \"Lorem Ipsum Dolor\"

" "

> Vertical Segment:
> \"Lorem Ipsum Dolor\"

" "

> Vertical Segment:
> \"Lorem Ipsum Dolor\"
EOS

    output = @parser.render(markdown)

# open('test.html', 'w') do |f|
# f << "<html>\n"
# f << "<head>\n"
# f << "<script src='https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>\n"
# f << "<script src='http://beta.semantic-ui.com/dist/semantic.min.js'></script>\n"
# f << "<link href='http://beta.semantic-ui.com/dist/semantic.min.css' media='all' rel='stylesheet' type='text/css' />\n"
# f << "</head>\n"
# f << "<body>\n"
# f << output
# f << "</body>\n"
# f << "</html>\n"
# end

    assert_equal "<div class=\"ui vertical segment\">\n<p>Lorem Ipsum Dolor</p></div>\n<p></p><div class=\"ui vertical segment\">\n<p>Lorem Ipsum Dolor</p></div>\n<p></p><div class=\"ui vertical segment\">\n<p>Lorem Ipsum Dolor</p></div>\n", output
  end

  def test_horizontal_segment
    markdown =
<<-EOS
> Horizontal Segment:
> " "

" "

> Horizontal Segment:
> " "

" "

> Horizontal Segment:
> " "
EOS

    output = @parser.render(markdown)
    assert_equal "<div class=\"ui horizontal segment\">\n<p></p></div>\n<p></p><div class=\"ui horizontal segment\">\n<p></p></div>\n<p></p><div class=\"ui horizontal segment\">\n<p></p></div>\n", output
  end

  def test_stacked_segment
    markdown =
<<-EOS
> Stacked Segment:
> \"Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.\"
EOS
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui stacked segment\">\n<p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.</p></div>\n", output
  end

  def test_piled_segment
    markdown =
<<-EOS
> Piled Segment:
> #### A Header
> \"Te eum doming eirmod, nominati pertinacia argumentum ad his. Ex eam alia facete scriptorem, est autem aliquip detraxit at. Usu ocurreret referrentur at, cu epicurei appellantur vix. Cum ea laoreet recteque electram, eos choro alterum definiebas in. Vim dolorum definiebas an. Mei ex natum rebum iisque.\"
> \"Audiam quaerendum eu sea, pro omittam definiebas ex. Te est latine definitiones. Quot wisi nulla ex duo. Vis sint solet expetenda ne, his te phaedrum referrentur consectetuer. Id vix fabulas oporteat, ei quo vide phaedrum, vim vivendum maiestatis in.\"
> \"Eu quo homero blandit intellegebat. Incorrupte consequuntur mei id. Mei ut facer dolores adolescens, no illum aperiri quo, usu odio brute at. Qui te porro electram, ea dico facete utroque quo. Populo quodsi te eam, wisi everti eos ex, eum elitr altera utamur at. Quodsi convenire mnesarchum eu per, quas minimum postulant per id.\"
EOS
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui piled segment\"><h4 class=\"ui header\">A Header</h4><p>Te eum doming eirmod, nominati pertinacia argumentum ad his. Ex eam alia facete scriptorem, est autem aliquip detraxit at. Usu ocurreret referrentur at, cu epicurei appellantur vix. Cum ea laoreet recteque electram, eos choro alterum definiebas in. Vim dolorum definiebas an. Mei ex natum rebum iisque.</p>\n<p>Audiam quaerendum eu sea, pro omittam definiebas ex. Te est latine definitiones. Quot wisi nulla ex duo. Vis sint solet expetenda ne, his te phaedrum referrentur consectetuer. Id vix fabulas oporteat, ei quo vide phaedrum, vim vivendum maiestatis in.</p>\n<p>Eu quo homero blandit intellegebat. Incorrupte consequuntur mei id. Mei ut facer dolores adolescens, no illum aperiri quo, usu odio brute at. Qui te porro electram, ea dico facete utroque quo. Populo quodsi te eam, wisi everti eos ex, eum elitr altera utamur at. Quodsi convenire mnesarchum eu per, quas minimum postulant per id.</p></div>\n", output
  end

  def test_disabled_state
    markdown =
<<-EOS
> Disabled Segment:
> " "
EOS
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui disabled segment\">\n<p></p></div>\n", output
  end

  def test_disabled_state_on_all_types
    markdown = "> Disabled Segment:\n> \"Lorem Ipsum Dolor\""
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui disabled segment\">\n<p>Lorem Ipsum Dolor</p></div>\n", output

    markdown =
<<-EOS
> Vertical Disabled Segment:
> \"Lorem Ipsum Dolor\"

" "

> Vertical Disabled Segment:
> \"Lorem Ipsum Dolor\"

" "

> Vertical Disabled Segment:
> \"Lorem Ipsum Dolor\"
EOS

    output = @parser.render(markdown)
    assert_equal "<div class=\"ui vertical disabled segment\">\n<p>Lorem Ipsum Dolor</p></div>\n<p></p><div class=\"ui vertical disabled segment\">\n<p>Lorem Ipsum Dolor</p></div>\n<p></p><div class=\"ui vertical disabled segment\">\n<p>Lorem Ipsum Dolor</p></div>\n", output

    markdown =
<<-EOS
> Horizontal Disabled Segment:
> " "

" "

> Horizontal Disabled Segment:
> " "

" "

> Horizontal Disabled Segment:
> " "
EOS

    output = @parser.render(markdown)
    assert_equal "<div class=\"ui horizontal disabled segment\">\n<p></p></div>\n<p></p><div class=\"ui horizontal disabled segment\">\n<p></p></div>\n<p></p><div class=\"ui horizontal disabled segment\">\n<p></p></div>\n", output

    markdown =
<<-EOS
> Stacked Disabled Segment:
> \"Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.\"
EOS
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui stacked disabled segment\">\n<p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.</p></div>\n", output

    markdown =
<<-EOS
> Piled Disabled Segment:
> #### A Header
> \"Te eum doming eirmod, nominati pertinacia argumentum ad his. Ex eam alia facete scriptorem, est autem aliquip detraxit at. Usu ocurreret referrentur at, cu epicurei appellantur vix. Cum ea laoreet recteque electram, eos choro alterum definiebas in. Vim dolorum definiebas an. Mei ex natum rebum iisque.\"
> \"Audiam quaerendum eu sea, pro omittam definiebas ex. Te est latine definitiones. Quot wisi nulla ex duo. Vis sint solet expetenda ne, his te phaedrum referrentur consectetuer. Id vix fabulas oporteat, ei quo vide phaedrum, vim vivendum maiestatis in.\"
> \"Eu quo homero blandit intellegebat. Incorrupte consequuntur mei id. Mei ut facer dolores adolescens, no illum aperiri quo, usu odio brute at. Qui te porro electram, ea dico facete utroque quo. Populo quodsi te eam, wisi everti eos ex, eum elitr altera utamur at. Quodsi convenire mnesarchum eu per, quas minimum postulant per id.\"
EOS
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui piled disabled segment\"><h4 class=\"ui header\">A Header</h4><p>Te eum doming eirmod, nominati pertinacia argumentum ad his. Ex eam alia facete scriptorem, est autem aliquip detraxit at. Usu ocurreret referrentur at, cu epicurei appellantur vix. Cum ea laoreet recteque electram, eos choro alterum definiebas in. Vim dolorum definiebas an. Mei ex natum rebum iisque.</p>\n<p>Audiam quaerendum eu sea, pro omittam definiebas ex. Te est latine definitiones. Quot wisi nulla ex duo. Vis sint solet expetenda ne, his te phaedrum referrentur consectetuer. Id vix fabulas oporteat, ei quo vide phaedrum, vim vivendum maiestatis in.</p>\n<p>Eu quo homero blandit intellegebat. Incorrupte consequuntur mei id. Mei ut facer dolores adolescens, no illum aperiri quo, usu odio brute at. Qui te porro electram, ea dico facete utroque quo. Populo quodsi te eam, wisi everti eos ex, eum elitr altera utamur at. Quodsi convenire mnesarchum eu per, quas minimum postulant per id.</p></div>\n", output

  end

  def test_loading_state
    markdown =
<<-EOS
> Loading Segment:
> " "
EOS
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui loading segment\">\n<p></p></div>\n", output
  end

  def test_loading_state_on_all_types
    markdown = "> Loading Segment:\n> \"Lorem Ipsum Dolor\""
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui loading segment\">\n<p>Lorem Ipsum Dolor</p></div>\n", output

    markdown =
<<-EOS
> Vertical Loading Segment:
> \"Lorem Ipsum Dolor\"

" "

> Vertical Loading Segment:
> \"Lorem Ipsum Dolor\"

" "

> Vertical Loading Segment:
> \"Lorem Ipsum Dolor\"
EOS

    output = @parser.render(markdown)
    assert_equal "<div class=\"ui vertical loading segment\">\n<p>Lorem Ipsum Dolor</p></div>\n<p></p><div class=\"ui vertical loading segment\">\n<p>Lorem Ipsum Dolor</p></div>\n<p></p><div class=\"ui vertical loading segment\">\n<p>Lorem Ipsum Dolor</p></div>\n", output

    markdown =
<<-EOS
> Horizontal Loading Segment:
> " "

" "

> Horizontal Loading Segment:
> " "

" "

> Horizontal Loading Segment:
> " "
EOS

    output = @parser.render(markdown)
    assert_equal "<div class=\"ui horizontal loading segment\">\n<p></p></div>\n<p></p><div class=\"ui horizontal loading segment\">\n<p></p></div>\n<p></p><div class=\"ui horizontal loading segment\">\n<p></p></div>\n", output

    markdown =
<<-EOS
> Stacked Loading Segment:
> \"Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.\"
EOS
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui stacked loading segment\">\n<p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.</p></div>\n", output

    markdown =
<<-EOS
> Piled Loading Segment:
> #### A Header
> \"Te eum doming eirmod, nominati pertinacia argumentum ad his. Ex eam alia facete scriptorem, est autem aliquip detraxit at. Usu ocurreret referrentur at, cu epicurei appellantur vix. Cum ea laoreet recteque electram, eos choro alterum definiebas in. Vim dolorum definiebas an. Mei ex natum rebum iisque.\"
> \"Audiam quaerendum eu sea, pro omittam definiebas ex. Te est latine definitiones. Quot wisi nulla ex duo. Vis sint solet expetenda ne, his te phaedrum referrentur consectetuer. Id vix fabulas oporteat, ei quo vide phaedrum, vim vivendum maiestatis in.\"
> \"Eu quo homero blandit intellegebat. Incorrupte consequuntur mei id. Mei ut facer dolores adolescens, no illum aperiri quo, usu odio brute at. Qui te porro electram, ea dico facete utroque quo. Populo quodsi te eam, wisi everti eos ex, eum elitr altera utamur at. Quodsi convenire mnesarchum eu per, quas minimum postulant per id.\"
EOS
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui piled loading segment\"><h4 class=\"ui header\">A Header</h4><p>Te eum doming eirmod, nominati pertinacia argumentum ad his. Ex eam alia facete scriptorem, est autem aliquip detraxit at. Usu ocurreret referrentur at, cu epicurei appellantur vix. Cum ea laoreet recteque electram, eos choro alterum definiebas in. Vim dolorum definiebas an. Mei ex natum rebum iisque.</p>\n<p>Audiam quaerendum eu sea, pro omittam definiebas ex. Te est latine definitiones. Quot wisi nulla ex duo. Vis sint solet expetenda ne, his te phaedrum referrentur consectetuer. Id vix fabulas oporteat, ei quo vide phaedrum, vim vivendum maiestatis in.</p>\n<p>Eu quo homero blandit intellegebat. Incorrupte consequuntur mei id. Mei ut facer dolores adolescens, no illum aperiri quo, usu odio brute at. Qui te porro electram, ea dico facete utroque quo. Populo quodsi te eam, wisi everti eos ex, eum elitr altera utamur at. Quodsi convenire mnesarchum eu per, quas minimum postulant per id.</p></div>\n", output
  end

  def test_inverted_variation
    markdown =
<<-EOS
> Inverted Segment:
> "I'm here to tell you something, and you will probably read me first."
EOS
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui inverted segment\">\n<p>I&rsquo;m here to tell you something, and you will probably read me first.</p></div>\n", output
  end

  def test_attached_variation
    markdown =
<<-EOS
> Top Attached Segment:
> "This segment is on top"

" "

> Attached Segment:
> "This segment is attached on both sides"

" "

> Bottom Attached Segment:
> "This segment is on bottom"
EOS
    output = @parser.render(markdown)
    assert_equal "<div class=\"ui top attached segment\">\n<p>This segment is on top</p></div>\n<p></p><div class=\"ui attached segment\">\n<p>This segment is attached on both sides</p></div>\n<p></p><div class=\"ui bottom attached segment\">\n<p>This segment is on bottom</p></div>\n", output
  end

  def test_attached_variation_2
    markdown =
<<-EOS
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

__Bottom Attached Warning Message|Icon:Warning,Text:You\'ve reached the end of this content segment\!__
EOS
    output = @parser.render(markdown)
    assert_equal "<h5 class=\"ui top attached header\">Dogs</h5><div class=\"ui attached segment\">\n<p>Dogs are one type of animal</p></div>\n<p></p><h5 class=\"ui attached header\">Cats</h5><div class=\"ui attached segment\">\n<p>Cats are thought of as being related to dogs, but only humans think this.</p></div>\n<p></p><h5 class=\"ui attached header\">Lions</h5><div class=\"ui attached segment\">\n<p>Humans don&rsquo;t think of lions as being like cats, but they are.</p></div>\n<p></p><div class=\"ui bottom attached warning message\"><i class=\"warning icon\"></i>You&rsquo;ve reached the end of this content segment!</div>\n", output
  end

  def test_padded
    markdown =
<<-EOS
> Padded Segment:
> " "
EOS

    output = @parser.render(markdown)
    assert_equal "<div class=\"ui padded segment\">\n<p></p></div>\n", output
  end


end