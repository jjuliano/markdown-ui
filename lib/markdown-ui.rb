# coding: UTF-8

require 'redcarpet'
require 'nokogiri'
require 'ostruct'
require 'cgi'

require_relative 'markdown-ui/shared'

# Load all component gems
require_relative '../components/collections/markdown-ui-breadcrumb/lib/markdown-ui-breadcrumb'
require_relative '../components/collections/markdown-ui-form/lib/markdown-ui-form'
require_relative '../components/collections/markdown-ui-grid/lib/markdown-ui-grid'
require_relative '../components/collections/markdown-ui-menu/lib/markdown-ui-menu'
require_relative '../components/collections/markdown-ui-message/lib/markdown-ui-message'
require_relative '../components/collections/markdown-ui-table/lib/markdown-ui-table'
require_relative '../components/elements/markdown-ui-button/lib/markdown-ui-button'
require_relative '../components/elements/markdown-ui-container/lib/markdown-ui-container'
require_relative '../components/elements/markdown-ui-content/lib/markdown-ui-content'
require_relative '../components/elements/markdown-ui-divider/lib/markdown-ui-divider'
require_relative '../components/elements/markdown-ui-flag/lib/markdown-ui-flag'
require_relative '../components/elements/markdown-ui-header/lib/markdown-ui-header'
require_relative '../components/elements/markdown-ui-icon/lib/markdown-ui-icon'
require_relative '../components/elements/markdown-ui-image/lib/markdown-ui-image'
require_relative '../components/elements/markdown-ui-input/lib/markdown-ui-input'
require_relative '../components/elements/markdown-ui-label/lib/markdown-ui-label'
require_relative '../components/elements/markdown-ui-list/lib/markdown-ui-list'
require_relative '../components/elements/markdown-ui-loader/lib/markdown-ui-loader'
require_relative '../components/elements/markdown-ui-segment/lib/markdown-ui-segment'
require_relative '../components/elements/markdown-ui-step/lib/markdown-ui-step'
require_relative '../components/modules/markdown-ui-accordion/lib/markdown-ui-accordion'
require_relative '../components/modules/markdown-ui-dropdown/lib/markdown-ui-dropdown'
require_relative '../components/modules/markdown-ui-modal/lib/markdown-ui-modal'
require_relative '../components/modules/markdown-ui-popup/lib/markdown-ui-popup'
require_relative '../components/modules/markdown-ui-progress/lib/markdown-ui-progress'
require_relative '../components/modules/markdown-ui-tab/lib/markdown-ui-tab'
require_relative '../components/shared/markdown-ui-shared/lib/markdown-ui-shared'
require_relative '../components/views/markdown-ui-card/lib/markdown-ui-card'
require_relative '../components/views/markdown-ui-comment/lib/markdown-ui-comment'
require_relative '../components/views/markdown-ui-feed/lib/markdown-ui-feed'
require_relative '../components/views/markdown-ui-item/lib/markdown-ui-item'
require_relative '../components/views/markdown-ui-statistic/lib/markdown-ui-statistic'

['markdown-ui/**/*.rb'].each do |dir|
  Dir[File.join(File.dirname(__FILE__), dir)].sort.each { |f| require_relative f }
end

module MarkdownUI
  class Renderer < Redcarpet::Render::HTML
    def initialize(options = {})
      super(options)
    end

    include MarkdownUI::Renderers::Header
    include MarkdownUI::Renderers::Quote
    include MarkdownUI::Renderers::Link
    include MarkdownUI::Renderers::List
    include MarkdownUI::Renderers::BlockQuote
    include MarkdownUI::Renderers::DoubleEmphasis
    include MarkdownUI::Renderers::Emphasis
    include MarkdownUI::Renderers::Paragraph
    include MarkdownUI::Renderers::HorizontalRule

    def code_block(code, language)
      if language
        %(<pre><code class="language-#{language}">#{CGI.escapeHTML(code)}</code></pre>)
      else
        %(<pre><code>#{CGI.escapeHTML(code)}</code></pre>)
      end
    end

    def codespan(code)
      %(<code>#{CGI.escapeHTML(code)}</code>)
    end

    protected

    def html
      if block_given?
        HTMLFormatter.new(yield).to_html
      end
    end
  end
end
