# coding: UTF-8
require 'securerandom'

module MarkdownUI
  module Button
    class Toggle
      def initialize(content, klass = nil, _id = nil)
        @content                          = content
        @klass                            = klass
        @id                               = _id
        @inactive_content, @active_content = content.is_a?(Array) ? content : content.split(';')
      end

      def render
        uuid             ||= SecureRandom.uuid.gsub("-", "_")
        klass            = "ui #{@klass} #{uuid} toggle button"
        _id              = @id
        inactive_content = @inactive_content
        active_content   = @active_content
        
        content = [
          MarkdownUI::ButtonTag.new(inactive_content, klass, _id).render,
          MarkdownUI::ScriptTag.new("
    $(document)
      .ready(function() {
        $('.ui.#{uuid}.toggle.button')
        .state({
          text: {
            inactive : '#{inactive_content}',
            active   : '#{active_content}'
          }
        })
      ;
    })
    ;
"
).render].join
        
        MarkdownUI::FieldTag.new(content).render
      end
    end
  end
end
