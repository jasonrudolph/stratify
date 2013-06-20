require "tilt"

module Stratify
  module Renderable
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def template(data = nil)
        @template = data unless data.nil?
        @template
      end

      def template_format(format = nil)
        @template_format = format unless format.nil?
        @template_format || default_template_format
      end

      def default_template_format
        :erb
      end
    end

    def to_html
      template_handler = Tilt[self.class.template_format].new { self.class.template.strip }
      template_handler.render(presenter)
    end

    # Returns the object that will be passed to the template for rendering.
    #
    # The default implementation returns 'self' (i.e., the renderable object).
    #
    # Subclasses may optionally override this method to provide an object
    # better suited for use in rendering (e.g., an object implementing the
    # presenter pattern).
    def presenter
      self
    end
  end
end
