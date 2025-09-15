module MarkdownUI
  module Renderers
    module Quote
      def quote(text)
        rendered_content = HtmlBeautifier.beautify("<p>#{text}</p>", indent: "  ")
        if rendered_content.include?("&quot;&quot;") || rendered_content.include?("&quot; &quot;") ||
           rendered_content.include?("&#39;&#39;") || rendered_content.include?("&#39; &#39;") ||
           text.strip.empty?
          html { "<p></p>" }
        else
          html { "<p>#{text}</p>" }
        end
      end
    end
  end
end
