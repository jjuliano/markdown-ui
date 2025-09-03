module MarkdownUI
  class Parser
    def initialize(options = {})
      @beautify = options.fetch(:beautify, false)

      # Configure renderer options based on beautify setting
      renderer_options = {}
      if @beautify
        renderer_options = {
          hard_wrap: true,
          prettify: true,
          xhtml: true
        }
      end

      @parser = Redcarpet::Markdown.new(MarkdownUI::Renderer.new(renderer_options),
                                        quote: true,
                                        tables: true,
                                        fenced_code_blocks: true,
                                        disable_indented_code_blocks: false)
    end

    def render(markdown, options = {})
      beautify = options.fetch(:beautify, @beautify)

      if beautify != @beautify
        # Create new parser with different beautification settings
        renderer_options = beautify ? {
          hard_wrap: true,
          prettify: true,
          xhtml: true
        } : {}

        parser = Redcarpet::Markdown.new(MarkdownUI::Renderer.new(renderer_options),
                                        quote: true,
                                        tables: true,
                                        fenced_code_blocks: true,
                                        disable_indented_code_blocks: false)
        parser.render(markdown)
      else
        @parser.render(markdown)
      end
    end
  end
end

