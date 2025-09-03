# frozen_string_literal: true

module MarkdownUI
  module Components
    # Kitchen Sink Elements - Comprehensive Semantic UI 2.5.0 component support
    # Based on https://semantic-ui.com/kitchen-sink.html

    # Base element class for all kitchen sink components
    class BaseElement
      attr_reader :content, :modifiers, :attributes

      def initialize(element, content = '')
        # Parse element to extract modifiers
        element_parts = element.to_s.split
        @element_name = element_parts.last&.downcase
        @modifiers = element_parts[0..-2].map(&:downcase)
        @content = content.to_s
        @attributes = {}
      end

      protected

      def css_class
        classes = ['ui']
        classes.concat(@modifiers) if @modifiers.any?
        classes << (@element_name || element_name)
        classes.join(' ')
      end

      def html_attributes
        return '' if @attributes.empty?

        attr_strings = @attributes.map do |key, value|
          %[#{key}="#{escape_html(value)}"]
        end

        ' ' + attr_strings.join(' ')
      end

      def has_modifier?(modifier)
        @modifiers.include?(modifier.to_s.downcase)
      end

      def get_attribute(key, default = nil)
        @attributes[key.to_s] || @attributes[key.to_sym] || default
      end

      def escape_html(text)
        return '' if text.nil?

        text.to_s
          .gsub('&', '&amp;')
          .gsub('<', '&lt;')
          .gsub('>', '&gt;')
          .gsub('"', '&quot;')
          .gsub("'", '&#39;')
      end

      def parse_nested_content(content)
        # Simple content parsing - can be enhanced
        return '' if content.nil?
        content.to_s.strip
      end
    end

    module Elements
      class RevealElement < BaseElement
        def render
          "<div class=\"#{css_class}\"#{html_attributes}>\n  #{parse_nested_content(@content)}\n</div>"
        end

        def element_name
          'reveal'
        end
      end

      class LoaderElement < BaseElement
        def render
          loader_text = @content.to_s.strip
          loader_text = "Loading..." if loader_text.empty?

          if has_modifier?('inline')
            %[<div class="#{css_class}"#{html_attributes}>#{escape_html(loader_text)}</div>]
          else
            %[<div class="ui dimmer">\n  <div class="#{css_class}"#{html_attributes}>#{escape_html(loader_text)}</div>\n</div>]
          end
        end

        def element_name
          'loader'
        end
      end

      class FlagElement < BaseElement
        def render
          flag_code = @content.to_s.strip.downcase
          # Use ui class structure for consistency
          %[<div class="#{css_class}"><i class="#{flag_code} flag"></i></div>]
        end

        def element_name
          'flag'
        end
      end

      class RailElement < BaseElement
        def render
          position = has_modifier?('left') ? 'left' : 'right'
          %[<div class="ui #{position} #{css_class}"#{html_attributes}>\n  #{parse_nested_content(@content)}\n</div>]
        end

        def element_name
          'rail'
        end
      end

      class SidebarElement < BaseElement
        def render
          %[<div class="#{css_class}"#{html_attributes}>\n  #{parse_nested_content(@content)}\n</div>]
        end

        def element_name
          'sidebar'
        end
      end

      class StickyElement < BaseElement
        def render
          %[<div class="#{css_class}"#{html_attributes}>\n  #{parse_nested_content(@content)}\n</div>]
        end

        def element_name
          'sticky'
        end
      end
    end

    module Collections
      class BreadcrumbElement < BaseElement
        def render
          items = @content.to_s.split(/[,|>]/).map(&:strip)
          breadcrumb_html = []
          breadcrumb_html << %[<div class="#{css_class}"#{html_attributes}>]

          items.each_with_index do |item, index|
            if index == items.length - 1
              breadcrumb_html << %[  <div class="active section">#{escape_html(item)}</div>]
            else
              breadcrumb_html << %[  <a class="section">#{escape_html(item)}</a>]
              breadcrumb_html << %[  <div class="divider"> / </div>]
            end
          end

          breadcrumb_html << %[</div>]
          breadcrumb_html.join("\n")
        end

        def element_name
          'breadcrumb'
        end
      end

      class TableElement < BaseElement
        def render
          %[<table class="#{css_class}"#{html_attributes}>\n  #{parse_nested_content(@content)}\n</table>]
        end

        def element_name
          'table'
        end
      end
    end

    module Views
      class FeedElement < BaseElement
        def render
          %[<div class="#{css_class}"#{html_attributes}>\n  #{parse_nested_content(@content)}\n</div>]
        end

        def element_name
          'feed'
        end
      end

      class StatisticElement < BaseElement
        def render
          parts = @content.to_s.split(/[:\n]/, 2)
          value = parts[0]&.strip || ''
          label = parts[1]&.strip || ''

          statistic_html = []
          statistic_html << %[<div class="#{css_class}"#{html_attributes}>]
          statistic_html << %[  <div class="value">#{escape_html(value)}</div>]
          statistic_html << %[  <div class="label">#{escape_html(label)}</div>] unless label.empty?
          statistic_html << %[</div>]

          statistic_html.join("\n")
        end

        def element_name
          'statistic'
        end
      end

      class AdvertisementElement < BaseElement
        def render
          %[<div class="#{css_class}"#{html_attributes}>\n  #{parse_nested_content(@content)}\n</div>]
        end

        def element_name
          'advertisement'
        end
      end
    end

    module Modules
      class CheckboxElement < BaseElement
        def render
          checkbox_text = @content.to_s.strip
          checkbox_type = has_modifier?('radio') ? 'radio' : 'checkbox'

          checkbox_html = []
          checkbox_html << %[<div class="#{css_class}"#{html_attributes}>]
          checkbox_html << %[  <input type="#{checkbox_type}" />]
          checkbox_html << %[  <label>#{escape_html(checkbox_text)}</label>] unless checkbox_text.empty?
          checkbox_html << %[</div>]

          checkbox_html.join("\n")
        end

        def element_name
          'checkbox'
        end
      end

      class DimmerElement < BaseElement
        def render
          %[<div class="#{css_class}"#{html_attributes}>\n  #{parse_nested_content(@content)}\n</div>]
        end

        def element_name
          'dimmer'
        end
      end

      class EmbedElement < BaseElement
        def render
          embed_url = @content.to_s.strip

          embed_html = []
          embed_html << %[<div class="#{css_class}"#{html_attributes}>]

          if embed_url.empty?
            embed_html << %[  <div class="placeholder">Embed content</div>]
          else
            embed_html << %[  <iframe src="#{escape_html(embed_url)}" frameborder="0" allowfullscreen></iframe>]
          end

          embed_html << %[</div>]
          embed_html.join("\n")
        end

        def element_name
          'embed'
        end
      end

      class RatingElement < BaseElement
        def render
          rating_value = @content.to_s.strip
          max_rating = get_attribute('max', '5').to_i
          current_rating = rating_value.to_f

          rating_html = []
          rating_html << %[<div class="#{css_class}"#{html_attributes}>]

          (1..max_rating).each do |i|
            star_class = i <= current_rating ? 'active icon' : 'icon'
            rating_html << %[  <i class="#{star_class}"></i>]
          end

          rating_html << %[</div>]
          rating_html.join("\n")
        end

        def element_name
          'rating'
        end
      end

      class SearchElement < BaseElement
        def render
          placeholder = @content.to_s.strip
          placeholder = "Search..." if placeholder.empty?

          search_html = []
          search_html << %[<div class="#{css_class}"#{html_attributes}>]
          search_html << %[  <div class="ui icon input">]
          search_html << %[    <input type="text" placeholder="#{escape_html(placeholder)}">]
          search_html << %[    <i class="search icon"></i>]
          search_html << %[  </div>]
          search_html << %[</div>]

          search_html.join("\n")
        end

        def element_name
          'search'
        end
      end

      class ShapeElement < BaseElement
        def render
          %[<div class="#{css_class}"#{html_attributes}>\n  #{parse_nested_content(@content)}\n</div>]
        end

        def element_name
          'shape'
        end
      end

      class TransitionElement < BaseElement
        def render
          %[<div class="#{css_class}"#{html_attributes}>\n  #{parse_nested_content(@content)}\n</div>]
        end

        def element_name
          'transition'
        end
      end
    end

    # Additional Complete Coverage Elements
    module Elements
      class StepElement < BaseElement
        def render
          step_content = parse_step_content
          %[<div class="#{css_class}"#{html_attributes}>\n  #{step_content}\n</div>]
        end

        def element_name
          'step'
        end

        private

        def parse_step_content
          return parse_nested_content(@content) if @content.is_a?(String) && !@content.include?('|')

          # Handle structured content: "Icon:name|Title|Description"
          parts = @content.to_s.split('|')
          step_html = []
          content_parts = []

          parts.each do |part|
            part = part.strip
            if part.match(/^Icon:\s*(.+)$/i)
              icon_name = $1.strip.downcase.gsub(' ', ' ')
              step_html << %[<i class="#{icon_name} icon"></i>]
            elsif content_parts.empty?
              # First non-icon part is title
              content_parts << %[<div class="title">#{escape_html(part)}</div>]
            else
              # Subsequent parts are description
              content_parts << %[<div class="description">#{escape_html(part)}</div>]
            end
          end

          # Wrap content parts in content div
          if content_parts.any?
            step_html << %[<div class="content">#{content_parts.join}</div>]
          end

          step_html.join
        end
      end

      class PlaceholderElement < BaseElement
        def render
          placeholder_lines = determine_lines
          lines_html = (1..placeholder_lines).map { %[<div class="line"></div>] }.join("\n  ")
          %[<div class="#{css_class}"#{html_attributes}>\n  #{lines_html}\n</div>]
        end

        def element_name
          'placeholder'
        end

        private

        def determine_lines
          # Check content for number of lines or use modifiers
          if @content.to_s.match?(/\d+/)
            @content.to_s.match(/\d+/)[0].to_i
          elsif @modifiers.find { |m| m.match?(/\d+/) }
            @modifiers.find { |m| m.match?(/\d+/) }.to_i
          else
            3 # Default to 3 lines
          end
        end
      end
    end

    module Modules
      class PopupElement < BaseElement
        def render
          trigger_text, popup_content = parse_popup_content

          if has_modifier?('button') || @modifiers.include?('button')
            %[<div class="#{trigger_css_class}" data-tooltip="#{escape_html(popup_content)}" data-position="top center"#{html_attributes}>#{escape_html(trigger_text)}</div>]
          else
            %[<div class="#{css_class}"#{html_attributes}>\n  <div class="ui popup">#{escape_html(popup_content)}</div>\n  <div class="trigger">#{escape_html(trigger_text)}</div>\n</div>]
          end
        end

        def element_name
          'popup'
        end

        private

        def parse_popup_content
          if @content.to_s.include?(':')
            parts = @content.to_s.split(':', 2)
            [parts[0].strip, parts[1].strip]
          else
            [@content.to_s.strip, 'Popup content']
          end
        end

        def trigger_css_class
          classes = ['ui']
          classes.concat(@modifiers.reject { |m| m == 'popup' })
          classes << 'button' if has_modifier?('button')
          classes.join(' ')
        end
      end

      class TabElement < BaseElement
        def render
          tabs = parse_tabs
          menu_html = build_tab_menu(tabs)
          content_html = build_tab_content(tabs)

          "#{menu_html}\n#{content_html}"
        end

        def element_name
          'tab'
        end

        private

        def parse_tabs
          # Expected format: "Tab1:Content1|Tab2:Content2"
          tabs_data = @content.to_s.split('|').map.with_index do |tab_str, index|
            if tab_str.include?(':')
              parts = tab_str.split(':', 2)
              { title: parts[0].strip, content: parts[1].strip, active: index == 0 }
            else
              { title: tab_str.strip, content: '', active: index == 0 }
            end
          end
          tabs_data
        end

        def build_tab_menu(tabs)
          menu_items = tabs.map.with_index do |tab, index|
            item_class = tab[:active] ? 'active item' : 'item'
            %[  <div class="#{item_class}" data-tab="tab#{index}">#{escape_html(tab[:title])}</div>]
          end

          %[<div class="ui tabular menu">\n#{menu_items.join("\n")}\n</div>]
        end

        def build_tab_content(tabs)
          content_panes = tabs.map.with_index do |tab, index|
            pane_class = tab[:active] ? 'ui active tab segment' : 'ui tab segment'
            content = tab[:content].empty? ? '' : %[<p>#{escape_html(tab[:content])}</p>]
            %[<div class="#{pane_class}" data-tab="tab#{index}">\n  #{content}\n</div>]
          end

          content_panes.join("\n")
        end
      end
    end

  end
end