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


end