# frozen_string_literal: true

module MarkdownUI
    # Token representing a parsed element
    class Token
      attr_reader :type, :content, :element_name, :modifiers, :attributes, :raw_content
      
      def initialize(type:, content: nil, element_name: nil, modifiers: [], attributes: {}, raw_content: nil)
        @type = type
        @content = content
        @element_name = element_name&.downcase&.strip
        @modifiers = Array(modifiers).map(&:downcase).map(&:strip)
        @attributes = attributes || {}
        @raw_content = raw_content
      end
      
      def ui_element?
        @type == :ui_element
      end

      def markdown?
        @type == :markdown
      end

      def text?
        @type == :text
      end

      def to_h
        {
          type: @type,
          content: @content,
          element_name: @element_name,
          modifiers: @modifiers,
          attributes: @attributes,
          raw_content: @raw_content
        }
      end

      def inspect
        "#<#{self.class.name} type=#{@type} element_name=#{@element_name} content=#{@content.inspect}>"
      end
    end
    
    # Tokenizer that can parse multiple UI element syntax formats
    class Tokenizer
      # Known UI element types for blockquote parsing
      KNOWN_UI_ELEMENTS = %w[
        accordion advertisement breadcrumb button buttons card cards checkbox column comment comments container content
        dimmer divider dropdown embed feed field fields flag form grid header icon image input
        item items divided relaxed label list loader menu message modal placeholder popup progress rail rating
        reveal search segment shape sidebar statistic step sticky tab table transition
      ]

      # Regex patterns for different syntax formats (case insensitive)
      SINGLE_UNDERSCORE_PATTERN = /_([^_]+(?:\|[^_]*)*?)_/
      DOUBLE_UNDERSCORE_PATTERN = /__([^_]+(?:\|[^_]*)*?)__/
      HORIZONTAL_DIVIDER_PATTERN = /^(_{3,}|-{3,})$/
      BLOCKQUOTE_PATTERN = /^(>+?\s*[^:\n]+:[^\n]*(?:\n>+?\s*[^\n]*|\n\s*\n>+?\s*[^\n]*)*)/mi
      EXTENDED_BUTTON_GROUP_PATTERN = /^(>\s*Basic\s+Buttons:[^\n]*(?:\n(?:>\s*[^\n]*|_{3,}|[^>\n]*))*)/mi
      HEADER_PATTERN = /^([#]{1,6})\s*(.+?)(?:\n|$)/
      COLON_SYNTAX_PATTERN = /^([^:\n]+):\s*\n(.+?)(?=\n\n|<!--|\Z)/m
      
      def initialize
        @patterns = [
          { name: :single_underscore, regex: SINGLE_UNDERSCORE_PATTERN, parser: :parse_single_underscore },
          { name: :double_underscore, regex: DOUBLE_UNDERSCORE_PATTERN, parser: :parse_double_underscore },
          { name: :horizontal_divider, regex: HORIZONTAL_DIVIDER_PATTERN, parser: :parse_horizontal_divider },
          { name: :extended_button_group, regex: EXTENDED_BUTTON_GROUP_PATTERN, parser: :parse_blockquote },
          { name: :blockquote, regex: BLOCKQUOTE_PATTERN, parser: :parse_blockquote },
          { name: :colon_syntax, regex: COLON_SYNTAX_PATTERN, parser: :parse_colon_syntax },
          { name: :header, regex: HEADER_PATTERN, parser: :parse_header }
        ]
        @token_cache = {}
      end
      
      # Tokenize markdown text into UI elements and regular content
      def tokenize(text)
        return [] if text.nil?
        text = text.to_s

        tokens = []
        remaining_text = text.dup
        
        # First pass: extract UI elements
        while remaining_text.length > 0
          earliest_match = nil
          earliest_pattern = nil
          
          # Find the earliest UI element pattern
          @patterns.each do |pattern|
            if match = remaining_text.match(pattern[:regex])
              # For blockquote pattern, only use it if it contains multiple lines, complex content, or known UI elements
              if pattern[:name] == :blockquote
                match_content = match[0]
                # Only use blockquote if it has multiple lines, contains double underscores, is a known container type, or is a known UI element
                has_multiple_lines = match_content.count("\n") > 1
                has_double_underscores = match_content.include?('__')
                is_container_type = match_content.match?(/^>\s*(.+?)\s*Container:/)
                # Check if it's a known UI element
                header_line = match_content.split("\n").first
                element_name_match = header_line.match(/^>\s*([^:\n]+)\s*:/)
                is_known_ui_element = false
                if element_name_match
                  header_content = element_name_match[1].strip
                  # Check if header contains a known UI element (e.g., "Menu" in "Menu:Vertical Fluid Tabular")
                  header_words = header_content.downcase.split(/\s+/)
                  is_known_ui_element = header_words.any? { |word| KNOWN_UI_ELEMENTS.include?(word) }
                  
                end
                next unless has_multiple_lines || has_double_underscores || is_container_type || is_known_ui_element
              end

              if earliest_match.nil? || match.begin(0) < earliest_match.begin(0)
                earliest_match = match
                earliest_pattern = pattern
              end
            end
          end
          
          if earliest_match
            # Add any text before the match
            if earliest_match.begin(0) > 0
              pre_text = remaining_text[0...earliest_match.begin(0)]
              tokens.concat(tokenize_text_content(pre_text))
            end
            
            # Parse the UI element
            ui_token = send(earliest_pattern[:parser], earliest_match)
            tokens << ui_token if ui_token
            
            # Continue with remaining text
            remaining_text = remaining_text[earliest_match.end(0)..-1]
          else
            # No more UI elements, add remaining text
            tokens.concat(tokenize_text_content(remaining_text))
            break
          end
        end
        
        tokens.compact
      end
      
      private

      def parse_single_underscore(match)
        content = match[1].strip
        return nil if content.empty?

        # Parse format: "Element Name|content|modifiers" or just "Element Name"
        parts = content.split('|')
        element_name = parts[0]&.strip
        element_content = parts[1..-1]

        # If no pipe separator, treat the entire content as the element content
        if parts.length == 1
          element_content = [content]
        end

        # Extract CSS classes and IDs from element name
        element_name, attributes = extract_css_classes_and_ids(element_name)

        # Extract modifiers from element name
        # Handle special cases like "AE Flag" -> element: "flag", modifiers: ["ae"]
        name_parts = element_name.split(/\s+/)

        # Check for known element types at the end
        known_elements = %w[
          accordion advertisement breadcrumb button buttons card checkbox column comment container content
          dimmer divider dropdown embed feed field fields flag form grid header icon image input
          item label list loader menu message modal placeholder popup progress rail rating
          reveal search segment shape sidebar statistic step sticky tab table transition
        ]
        base_name = nil
        modifiers = []

        # Look for known element, preferring matches from right to left
        name_parts_down = name_parts.map(&:downcase)

        # Find the rightmost known element in the name parts
        found_element = nil
        name_parts_down.reverse.each do |part|
          if known_elements.include?(part)
            found_element = part
            break
          end
        end

        if found_element
          base_name = found_element
          modifiers = name_parts_down - [found_element]
        end

        # Fallback: first word is element name
        if base_name.nil?
          base_name = name_parts[0]&.downcase
          modifiers = name_parts[1..-1]&.map(&:downcase) || []
        end

        # Create token
        Token.new(
          type: :ui_element,
          content: element_content.length == 1 ? element_content.first : element_content,
          element_name: base_name,
          modifiers: modifiers,
          attributes: attributes
        )
      end

      def parse_double_underscore(match)
        content = match[1].strip
        return nil if content.empty?

        # Parse format: "Element Name|content|modifiers"
        parts = content.split('|')
        element_name = parts[0]&.strip
        element_content = parts[1..-1]

        # Extract CSS classes and IDs from element name
        element_name, attributes = extract_css_classes_and_ids(element_name)

        # Extract modifiers from element name
        # Handle special cases like "Animated Button" -> element: "button", modifiers: ["animated"]
        name_parts = element_name.split(/\s+/)

        # Check for known element types at the end
        known_elements = %w[
          accordion advertisement breadcrumb button buttons card checkbox column comment container content
          dimmer divider dropdown embed feed field fields flag form grid header icon image input
          item label list loader menu message modal placeholder popup progress rail rating
          reveal search segment shape sidebar statistic step sticky tab table transition
        ]
        base_name = nil
        modifiers = []

        # Special handling for compound names that should map to message
        if element_name.downcase == 'list message'
          base_name = 'message'
          modifiers = []
        # Special handling for divider header
        elsif element_name.downcase.end_with?(' divider header')
          base_name = 'divider'
          # Extract modifiers from the beginning
          modifier_part = element_name.downcase.sub(' divider header', '').strip
          modifiers = modifier_part.split unless modifier_part.empty?
        else
        # Look for known element, preferring matches from right to left
        name_parts_down = name_parts.map(&:downcase)

        # Find the rightmost known element in the name parts
        found_element = nil
        name_parts_down.reverse.each do |part|
          if known_elements.include?(part)
            found_element = part
            break
          end
        end

        if found_element
          base_name = found_element
          modifiers = name_parts_down - [found_element]
        end
        end

        # Fallback: first word is element name
        if base_name.nil?
          base_name = name_parts[0]&.downcase
          modifiers = name_parts[1..-1]&.map(&:downcase) || []
        end

        # Extract ID and additional attributes from content parts that look like modifiers or IDs
        # First pass: extract modifiers from anywhere in the content (not just the end)
        element_content = element_content.reject do |part|
          part = part&.strip
          next false if part.nil? || part.empty?

          # Only extract lowercase modifiers to avoid conflicts with content that might use the same words
          if part.downcase == part && (is_element_specific_modifier?(part, base_name) || is_semantic_modifier?(part))
            modifiers << part unless modifiers.include?(part)  # Avoid duplicates
            true  # Remove this part from content
          else
            false # Keep this part in content
          end
        end

        # Second pass: extract IDs from remaining content parts (right to left)
        while element_content.length > 1
          last_part = element_content.last&.strip
          break if last_part.nil? || last_part.empty?

          if last_part.match?(/^(icon|detail|image)\s+/i)
            # Special content patterns (icon <name>, detail <text>, image <url>) should be preserved as content
            break
          else
            # Not a modifier or ID, stop processing
            break
          end
        end

        Token.new(
          type: :ui_element,
          element_name: base_name,
          content: element_content,
          modifiers: modifiers,
          attributes: attributes,
          raw_content: match[0]
        )
      end

      def parse_horizontal_divider(match)
        divider_text = match[0]

        # Determine if it's underscores or dashes
        if divider_text.start_with?('_')
          element_name = 'divider'
          modifiers = []
        else
          # For dashes, it might be a different type of divider
          element_name = 'divider'
          modifiers = []
        end

        Token.new(
          type: :ui_element,
          element_name: element_name,
          content: [],
          modifiers: modifiers,
          attributes: {},
          raw_content: match[0]
        )
      end

      def parse_header(match)
        hashes = match[1]
        header_text = match[2].strip

        # Determine header level from number of hashes
        level = hashes.length

        # Handle multi-line content: split on newlines and only use first line
        lines = header_text.split("\n")
        first_line = lines.first.strip
        remaining_lines = lines[1..-1]&.join("\n")&.strip

        # POLICY: Case insensitive - treat all headers as UI header elements
        # Parse modifiers from colon syntax for attached elements (needed for parser newline logic)
        element_content = [first_line]
        modifiers = ["h#{level}"]

        # Keep attached modifier in token for parser newline logic
        if first_line.include?(':')
          text_parts = first_line.split(':', 2)
          modifiers_text = text_parts[1].strip
          if !modifiers_text.empty?
            additional_modifiers = modifiers_text.split(',').map(&:strip).map(&:downcase)
            modifiers.concat(additional_modifiers)
          end
        end

        # If there's remaining content, include it in the element content
        if remaining_lines && !remaining_lines.empty?
          element_content = [first_line, remaining_lines]
        end

        Token.new(
          type: :ui_element,
          element_name: 'header',
          content: element_content,
          modifiers: modifiers,
          attributes: {},
          raw_content: match[0]
        )
      end

      def parse_blockquote(match)
        full_blockquote = match[1].gsub("\\n", "\n")
        lines = full_blockquote.split("\n")

        # First line contains element name and modifiers
        header_line = lines.first.strip
        header_content = header_line.sub(/^(\s*>)+/, '').sub(/:$/, '').strip

        # Extract CSS classes and IDs from header content
        header_content, attributes = extract_css_classes_and_ids(header_content)

        # Extract element name and modifiers from header
        # Handle cases like "Menu:Vertical Fluid Tabular" -> ["Menu", "Vertical", "Fluid", "Tabular"]
        header_parts = header_content.split(/[:,]\s*|\s+/).map(&:strip).reject(&:empty?)

        # Check for known element types
        known_elements = %w[
          accordion advertisement breadcrumb button buttons card checkbox column comment comments container content
          dimmer divider dropdown embed feed field fields flag form grid header icon image input
          item label list loader menu message modal placeholder popup progress rail rating
          reveal search segment shape sidebar statistic step sticky tab table transition
        ]
        base_name = nil
        modifiers = []

        # Special handling for compound names that should map to message
        header_content_down = header_content.downcase
        if header_content_down == 'list message' || header_content_down == 'message'
          base_name = 'message'
          modifiers = []
        # Special handling for divider header
        elsif header_content_down.end_with?(' divider header')
          base_name = 'divider'
          # Extract modifiers from the beginning
          modifier_part = header_content_down.sub(' divider header', '').strip
          modifiers = modifier_part.split unless modifier_part.empty?
          modifiers ||= []
          modifiers << 'header' # Add header as a modifier
        else
        # Look for known element, preferring matches from right to left
        header_parts_down = header_parts.map(&:downcase)

        # Find the rightmost known element in the header parts
        found_element = nil
        header_parts_down.reverse.each do |part|
          if known_elements.include?(part)
            found_element = part
            break
          end
        end

        if found_element
          base_name = found_element
          # Everything else becomes modifiers
          modifiers = header_parts_down.reject { |part| part == found_element }
        end
        end

        # Fallback: first word is element name
        if base_name.nil?
          base_name = header_parts[0]&.downcase
          modifiers = header_parts[1..-1]&.map(&:downcase) || []
        end

        # Parse content from remaining lines
        content_lines = lines[1..-1] || []
        content = parse_blockquote_content(content_lines)

        # For single-line blockquotes, extract content from the header line if no content was found
        if content.empty? && lines.length == 1
          # Extract content from the header line after the element name
          # e.g., "Button: Primary Submit" -> "Primary Submit"
          header_without_element = header_content.sub(/^#{Regexp.escape(base_name)}(\s+|\s*:\s*)/i, '')
          if !header_without_element.empty? && header_without_element != header_content
            content = [header_without_element.strip]
          end
        end

        Token.new(
          type: :ui_element,
          element_name: base_name,
          content: content,
          modifiers: modifiers,
          attributes: attributes,
          raw_content: match[0]
        )
      end
      
      def parse_blockquote_content(lines)
        return [] if lines.nil? || lines.empty?

        # Process lines to extract nested blockquote structure
        processed_lines = []
        lines.each do |line|
          # Count blockquote level
          level = count_blockquote_level(line)
          clean_line = line.sub(/^(\s*>)+/, '').strip

          # Check if this is a comments element by looking at the raw match content
          # The match content is available in the calling context, but we don't have it here
          # For now, check if any line contains "Comment:" - this is a heuristic
          is_comments_element = lines.any? { |l| l.include?('Comment:') }


          if is_comments_element && level > 1
            # For comments elements, preserve the full nesting structure
            # Add back (level - 1) markers to maintain nesting hierarchy
            markers = ">" * (level - 1)
            nested_line = markers + " " + clean_line
            processed_lines << nested_line
          elsif level > 1
            # This is nested content - add back one blockquote marker for proper parsing
            # This allows nested UI elements to be recognized correctly
            nested_line = ">" + " " + clean_line
            processed_lines << nested_line
          else
            # Regular content
            processed_lines << clean_line
          end
        end

        # Join all lines to preserve the nested structure
        joined_content = processed_lines.join("\n")

        # Return as array with the joined content
        [joined_content]
      end
      
      def count_blockquote_level(line)
        # Count consecutive > characters at the start of the line
        line.match(/^(>\s*)*/)[0].count('>')
      end

      def collect_nested_blockquote_from_index(all_lines, start_index, start_level)
        return [] unless start_index >= 0 && start_index < all_lines.length

        start_line = all_lines[start_index]
        nested_lines = [start_line]
        i = start_index + 1

        while i < all_lines.length
          line = all_lines[i]
          current_level = count_blockquote_level(line)

          if current_level >= start_level
            nested_lines << line
          else
            # We've reached a line with lower nesting level, stop collecting
            break
          end

          i += 1
        end

        nested_lines
      end
      
      def tokenize_text_content(text)
        return [] if text.nil? || text.empty?

        tokens = []

        # Check if text contains standard markdown
        if contains_markdown?(text)
          # Special handling for quoted whitespace - treat as empty paragraph
          if text.strip.match?(/^"\s*"$/m)
            tokens << Token.new(type: :markdown, content: "")
          else
            tokens << Token.new(type: :markdown, content: text)
          end
        else
          tokens << Token.new(type: :text, content: text)
        end

        tokens
      end

      def extract_nested_blockquote_from_lines(lines, start_index)
        return nil if lines.nil? || lines.empty? || start_index >= lines.length || lines[start_index].nil? || lines[start_index].strip.empty?

        base_level = count_blockquote_level(lines[start_index])
        return nil if base_level.nil? || base_level == 0

        nested_lines = []
        i = start_index

        while i < lines.length
          line = lines[i]
          break if line.nil?

          current_level = count_blockquote_level(line)
          if current_level.nil? || current_level < base_level
            # We've reached a line with lower blockquote level, stop
            break
          end

          nested_lines << line
          i += 1
        end

        nested_lines.empty? ? nil : nested_lines.join("\n")
      end

      def contains_markdown?(text)
        # Simple check for common markdown patterns
        markdown_patterns = [
          /\*\*.*?\*\*/, # Bold
          /\*.*?\*/,     # Italic
          /`.*?`/,       # Code
          /\[.*?\]\(.*?\)/, # Links
          /^#+\s/,       # Headers
          /^\* /,        # Lists
          /^> /,         # Blockquotes (not our UI blockquotes)
          /".*"/         # Quoted text (treat as markdown for proper rendering)
        ]

        # Also treat plain text as markdown (it should be wrapped in <p> tags)
        text.strip.length > 0 && (markdown_patterns.any? { |pattern| text.match?(pattern) } || !text.include?('<'))
      end

      def extract_css_classes_and_ids(element_name)
        return element_name, {} if element_name.nil? || element_name.empty?

        attributes = {}
        classes = []
        id_value = nil

        # Use regex to find all class and id patterns
        # This handles cases like: .class1.class2#id or #id.class1.class2
        class_pattern = /\.([^\s#.]+)/
        id_pattern = /#([^\s#.]+)/

        # Extract all classes
        element_name.scan(class_pattern) do |match|
          classes.concat(match[0].split('.').reject(&:empty?))
        end

        # Extract ID (take the last one if multiple)
        if element_name =~ id_pattern
          id_value = $1
        end

        # Remove class and id parts from element name
        clean_element_name = element_name.gsub(class_pattern, '').gsub(id_pattern, '').strip

        # Set attributes
        attributes['class'] = classes if classes.any?
        attributes['id'] = id_value if id_value

        # Return cleaned element name and attributes
        [clean_element_name, attributes]
      end

      def is_semantic_modifier?(text)
        # Common Semantic UI modifiers that shouldn't be treated as IDs
        semantic_modifiers = %w[
          primary secondary positive negative basic inverted tabular toggle fluid circular loading disabled
          mini tiny small medium large big huge massive
          red orange yellow olive green teal blue violet purple pink brown grey black
          animated fade vertical horizontal very
          celled striped definition structured stackable unstackable sortable fixed padded compact relaxed
          bulleted numbered link selection divided ordered collapsing
          warning error success focus centered inline transparent icon search
        ]

        # Handle multi-word modifiers
        words = text.downcase.split(/\s+/)
        words.all? { |word| semantic_modifiers.include?(word) }
      end
      
      def is_element_specific_modifier?(text, element_name)
        element_modifiers = {
          'list' => %w[bulleted numbered link selection animated relaxed divided celled ordered],
          'button' => %w[animated labeled icon toggle fluid circular loading],
          'menu' => %w[secondary pointing tabular text vertical popup dropdown borderless stackable],
          'table' => %w[celled striped definition structured stackable unstackable sortable fixed padded compact],
          'message' => %w[info warning error success positive negative],
          'header' => %w[block attached dividing icon sub],
          'input' => %w[text password email number search url tel date time checkbox radio],
          'image' => %w[fluid avatar bordered circular rounded spaced floated centered],
          'label' => %w[basic image pointing corner tag ribbon attached floating],
          'icon' => %w[fitted link circular bordered],
          'step' => %w[active completed disabled vertical ordered stackable fluid],
          'loader' => %w[active indeterminate text inline centered dimmer],
          'progress' => %w[indicating active success warning error attached inverted],
          'field' => %w[required disabled error inline grouped wide],
          'checkbox' => %w[checked disabled fitted indeterminate radio slider toggle],
          'dropdown' => %w[selection search button floating labeled icon loading error disabled active fluid compact pointing upward multiple],
          'accordion' => %w[styled fluid inverted active],
          'tab' => %w[secondary pointing tabular text],
          'popup' => %w[button icon basic primary secondary],
          'placeholder' => %w[line paragraph image header fluid inverted],
          'rail' => %w[left right internal attached dividing close very close],
          'reveal' => %w[fade move rotate],
          'dimmer' => %w[active inverted page blurring],
          'embed' => %w[active],
          'rating' => %w[star heart disabled],
          'search' => %w[category selection loading focus fluid],
          'shape' => %w[animating],
          'sidebar' => %w[left right top bottom visible hidden overlay push scale down rotate along inverted labeled icon vertical thin very thin wide very wide],
          'sticky' => %w[top bottom bound pushing],
          'transition' => %w[scale fade fly slide browse jiggle flash shake pulse tada bounce glow left right up down in out visible hidden animating],
          'advertisement' => %w[medium rectangle large rectangle vertical banner leaderboard mobile banner large mobile banner tablet leaderboard small rectangle square button small button skyscraper wide skyscraper banner half page panorama netboard large leaderboard billboard centered test],
          'comment' => %w[collapsed minimal threaded],
          'feed' => %w[small large],
          'item' => %w[divided relaxed very relaxed link],
          'statistic' => %w[inverted horizontal],
          'breadcrumb' => %w[section divider],
          'card' => %w[fluid centered raised link],
          'container' => %w[text fluid],
          'content' => %w[active visible hidden],
          'divider' => %w[vertical horizontal inverted fitted hidden clearing section header],
          'flag' => %w[],
          'form' => %w[loading success error warning info inverted],
          'grid' => %w[equal width stackable doubling relaxed padded centered],
          'modal' => %w[fullscreen basic inverted],
          'segment' => %w[raised stacked piled vertical horizontal inverted padded compact circular clearing basic secondary tertiary],
          'loader' => %w[active indeterminate text inline centered dimmer],
        }
        
        modifiers_for_element = element_modifiers[element_name] || []
        modifiers_for_element.include?(text.downcase)
      end

      # Get statistics about tokenization
      public
      def tokenize_stats(text)
        return {} if text.nil?

        tokens = tokenize(text)
        stats = {
          total_tokens: tokens.size,
          ui_elements: tokens.count(&:ui_element?),
          markdown_tokens: tokens.count(&:markdown?),
          text_tokens: tokens.count(&:text?),
          element_types: {}
        }

        tokens.select(&:ui_element?).each do |token|
          stats[:element_types][token.element_name] ||= 0
          stats[:element_types][token.element_name] += 1
        end

        stats
      end

      # Clear token cache
      public
      def clear_cache
        @token_cache = {} if @token_cache
      end

      # Get cache statistics
      public
      def cache_stats
        return { enabled: false } unless @token_cache
        {
          enabled: true,
          size: @token_cache.size,
          keys: @token_cache.keys.first(5)
        }
      end

      # Validate if text contains valid UI elements
      public
      def parse_colon_syntax(match)
        element_text = match[1].strip
        content_text = match[2].strip
        
        puts "DEBUG: parse_colon_syntax called with element_text = #{element_text.inspect}"
        
        # Parse the element text to extract name and modifiers
        words = element_text.downcase.split(/\s+/)
        
        # Find the element name (last word that matches known UI elements)
        element_name = words.reverse.find { |word| KNOWN_UI_ELEMENTS.include?(word) }
        element_name ||= 'div' # fallback
        
        # All other words become modifiers
        modifiers = words.reject { |word| word == element_name }
        
        
        # Create token
        UIElementToken.new(element_name, content_text, modifiers)
      end
      
      def has_ui_elements?(text)
        return false if text.nil?
        text = text.to_s

        @patterns.any? do |pattern|
          pattern[:regex].match?(text)
        end
      end
    end
end