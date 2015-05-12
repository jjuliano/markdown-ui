require "markdown_ui/version"

# coding: UTF-8
require 'redcarpet'
require 'ostruct'

['markdown_ui/**/*.rb'].each do |dir|
  Dir[File.join(File.dirname(__FILE__), dir)].sort.each { |f| require_relative f }
end

module MarkdownUI
  class Renderer < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants

    def paragraph(text)
      text
    end

    def double_emphasis(text)
      args = text.split("|")
      ui_element = args[0].split(" ")

      ui_content = if args[1].strip =~ /\,/
        args[1].split(",")
      else
        args[1].strip
      end

      ui_class = args.size > 2 ? args[2].downcase : nil

      mode = OpenStruct.new(
        :button?    => ui_element.grep(/button/i).any?,
        :icon?      => ui_element.grep(/icon/i).any?,
        :flag?      => ui_element.grep(/flag/i).any?,
        :image?     => ui_element.grep(/image/i).any?,
        :focusable? => ui_element.grep(/focusable/i).any?,
        :animated?  => ui_element.grep(/animated/i).any?,
        :labeled?   => ui_element.grep(/labeled/i).any?,
        :basic?     => ui_element.grep(/basic/i).any?,

        :message?   => ui_element.grep(/message/i).any?,
        :warning?   => ui_element.grep(/warning/i).any?
      )

      # Buttons

      if standard_button?(mode) && ui_element.size > 2
        MarkdownUI::CustomButton.new(ui_element.join(" "), ui_content, ui_class).render
      elsif mode.button? && standard_button?(mode)
        MarkdownUI::StandardButton.new(ui_content, ui_class).render
      elsif mode.button? && mode.icon? && mode.labeled?
        icon, label = ui_content
        MarkdownUI::LabeledIconButton.new(icon, label, ui_class).render
      elsif mode.button? && mode.icon? && !mode.labeled?
        MarkdownUI::IconButton.new(ui_content, ui_class).render
      elsif mode.button? && mode.focusable?
        MarkdownUI::FocusableButton.new(ui_content, ui_class).render
      elsif mode.button? && mode.basic?
        MarkdownUI::BasicButton.new(ui_content, ui_class).render
      elsif mode.button? && mode.animated?
        visible_content, hidden_content = ui_content.split(";")
        MarkdownUI::AnimatedButton.new(visible_content, hidden_content, ui_class).render

      # Message

      elsif mode.message? && ui_element.size > 2
        MarkdownUI::CustomMessage.new(ui_element.join(" "), ui_content, ui_class).render
      elsif mode.message? && standard_message?(mode)
        MarkdownUI::Message.new(ui_content, ui_class).render
      end

    end

    def block_quote(content)
      ui_element, actual_content = content.split(':')

      case ui_element
        when /segment/i
          MarkdownUI::Segment.new(ui_element, actual_content).render
        when /container/i
          MarkdownUI::Container.new(ui_element, actual_content).render
      end
    end

    def quote(text)
      "<p>#{text}</p>"
    end

    def header(text, level)
      MarkdownUI::Header.new(text, level).render
    end

    protected

    def standard_button?(mode)
      mode.button? && !mode.focusable? && !mode.animated? && !mode.icon? && !mode.labeled? && !mode.basic?
    end

    def standard_message?(mode)
      mode.message? && !mode.focusable? && !mode.animated? && !mode.icon? && !mode.labeled? && !mode.basic?
    end

  end
end
