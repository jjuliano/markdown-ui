# coding: UTF-8
require_relative 'test_helper'

class MenuTest < Redcarpet::TestCase
  def setup
    @parser = Redcarpet::Markdown.new(MarkdownUI::Renderer, quote: true)
  end

  def test_menu
    markdown =
<<-EOS
> Three Item Menu:
> [Editorials](# "active")
> [Reviews](#)
> [Upcoming Events](#)
EOS

    output = @parser.render(markdown)
    assert_equal "<div class=\"ui three item menu\">\n  <a class=\"ui active item\">Editorials</a>\n  <a class=\"ui item\">Reviews</a>\n  <a class=\"ui item\">Upcoming Events</a>\n</div>\n", output
  end
#
#   def test_menu_alternative
#     markdown =
# <<-EOS
# > Menu:
# > __Header|Changes in Service__
# > "We just updated our privacy policy here to better service our customers. We recommend reviewing the changes."
# EOS
#
#     output = @parser.render(markdown)
#     assert_equal "<div class=\"ui menu\">\n  <div class=\"ui header\">Changes in Service</div>\n  <p>We just updated our privacy policy here to better service our customers. We recommend reviewing the changes.</p>\n</div>\n", output
#   end
#
#   def test_list_menu
#     markdown =
# <<-EOS
# __List Menu|Header: New Site Features, List: You can now have cover images on blog pages;Drafts will now auto-save while writing__
# EOS
#
#     output = @parser.render(markdown)
#     assert_equal "<div class=\"ui menu\">\n  <div class=\"header\">New Site Features</div>\n  <ul class=\"list\">\n    <li>You can now have cover images on blog pages</li>\n    <li>Drafts will now auto-save while writing</li>\n  </ul>\n</div>\n", output
#   end
#
#   def test_list_menu_alternative
#     markdown =
# <<-EOS
# > List Menu:
# > __Header|New Site Features__
# >
# > * You can now have cover images on blog pages
# > * Drafts will now auto-save while writing
# EOS
#
#     output = @parser.render(markdown)
#     assert_equal "<div class=\"ui menu\">\n  <div class=\"ui header\">New Site Features</div>\n  <ul class=\"ui list\">\n    <li>You can now have cover images on blog pages</li>\n    <li>Drafts will now auto-save while writing</li>\n  </ul>\n</div>\n", output
#   end
end
