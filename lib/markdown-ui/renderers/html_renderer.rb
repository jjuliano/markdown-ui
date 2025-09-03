# frozen_string_literal: true

require 'htmlbeautifier'

module MarkdownUI
  module Renderers
      # HTML renderer that handles formatting and beautification
      class HTMLRenderer
        def initialize(options = {})
          @beautify = options.fetch(:beautify, false)
          @indent_size = options.fetch(:indent_size, 2)
        end

        # Format HTML with proper indentation and line breaks using HtmlBeautifier
        def format_html(html)
          return html unless @beautify
          return '' if html.nil? || html.strip.empty?

          begin
            # Beautify the HTML with specified indentation
            HtmlBeautifier.beautify(html, indent: ' ' * @indent_size)
          rescue
            # Fallback to original HTML if beautification fails
            html
          end
        end
      end
  end
end