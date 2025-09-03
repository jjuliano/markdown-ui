module MarkdownUI::Card
  class Element
    def initialize(element, content, klass = nil)
      @element = element
      @content = content
      @klass = klass
    end

    def render
      # Parse the content: "title|description|modifiers"
      parts = @content.split('|')
      title = parts[0] || ""
      description = parts[1] || ""
      modifiers = parts[2] || ""

      # If there are more than 3 parts, combine the middle parts as description
      if parts.length > 3
        description = parts[1..-2].join('|')
        modifiers = parts.last
      end


      # Build CSS classes
      classes = ['ui', 'card']

      # Add modifier classes
      if modifiers
        modifier_list = modifiers.split
        modifier_list.each do |modifier|
          case modifier.downcase
          when 'fluid'
            classes << 'fluid'
          when 'raised'
            classes << 'raised'
          when 'centered'
            classes << 'centered'
          when 'red', 'orange', 'yellow', 'olive', 'green', 'teal', 'blue', 'violet', 'purple', 'pink', 'brown', 'grey', 'black'
            classes << modifier.downcase
          when /^image\s+(.+)$/
            # Handle image modifier: "image url"
            @image_url = $1
          end
        end
      end

      # Build the card HTML
      card_class = classes.join(' ')

      html_parts = []
      html_parts << "<div class=\"#{card_class}\">"

      # Add image if specified
      if @image_url
        html_parts << "  <div class=\"image\">"
        html_parts << "    <img src=\"#{@image_url}\" />"
        html_parts << "  </div>"
      end

      # Add content section
      html_parts << "  <div class=\"content\">"
      html_parts << "    <div class=\"header\">#{title}</div>" unless title.empty?
      html_parts << "    <div class=\"description\">#{description}</div>" unless description.empty?
      html_parts << "  </div>"

      html_parts << "</div>"

      html_parts.join("\n")
    end
  end
end
