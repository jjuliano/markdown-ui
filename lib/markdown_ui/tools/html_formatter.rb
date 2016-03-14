module MarkdownUI
  module Tools
    class HTMLFormatter
      def initialize(text)
        @doc = Nokogiri::XML(text, &:noblanks).to_xhtml(indent: 2)
      end

      def to_html
        @doc
      end
      
      def self.filter_text(text)
        full_sanitizer = Loofah.fragment(text).scrub!(:whitewash)
        CGI::unescape_html(full_sanitizer.to_text)
      end      
    end
  end
end