# frozen_string_literal: true

module MarkdownUI
    # Registry for UI element handlers
    class ElementRegistry
      class ElementNotFoundError < StandardError; end
      class InvalidHandlerError < StandardError; end
      
      def initialize
        @handlers = {}
      end
      
      # Register an element handler
      def register(name, handler_class)
        element_name = normalize_name(name)
        
        unless valid_handler?(handler_class)
          raise InvalidHandlerError, "Handler must respond to #new and instances must respond to #render"
        end
        
        @handlers[element_name] = handler_class
      end
      
      # Check if an element is registered
      def registered?(name)
        @handlers.key?(normalize_name(name))
      end
      
      # Get handler class for an element
      def get_handler(name)
        element_name = normalize_name(name)
        @handlers[element_name]
      end
      
      # Render an element
      def render(name, content, modifiers = [], attributes = {})
        element_name = normalize_name(name)
        handler_class = @handlers[element_name]

        return nil unless handler_class

        begin
          handler = handler_class.new(content, modifiers, attributes, element_name)
          handler.render
        rescue => e
          # Always raise exceptions in test environment (check for test-related env vars)
          if ENV['RACK_ENV'] == 'test' || ENV['RAILS_ENV'] == 'test' || defined?(::Test) || defined?(::Minitest)
            raise e
          end

          # Fallback rendering for production
          "<div class=\"ui-element-error\" data-element=\"#{element_name}\">Error rendering #{element_name}</div>"
        end
      end
      
      # List all registered elements
      def list
        @handlers.keys.sort
      end
      
      # Remove an element handler
      def unregister(name)
        element_name = normalize_name(name)
        @handlers.delete(element_name)
      end
      
      # Clear all handlers
      def clear
        @handlers.clear
      end
      
      private
      
      def normalize_name(name)
        name.to_s.downcase.strip
      end
      
      def valid_handler?(handler_class)
        return false unless handler_class.respond_to?(:new)
        
        # Check if instances will respond to render
        # We can't instantiate without args, so we check the class definition
        handler_class.instance_methods.include?(:render) ||
        handler_class.private_instance_methods.include?(:render)
      end
    end
end