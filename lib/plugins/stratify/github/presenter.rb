require 'action_view'
require 'rinku'

module Stratify
  module GitHub
    class Presenter
      include ActionView::Helpers::UrlHelper

      def initialize(activity)
        @activity = activity
      end

      def text
        clazz = Stratify::GitHub::Event.const_get(@activity.event_type)
        return clazz.text(@activity)
      end

      def to_html
        linkify_urls(text)
      end

      private

      def linkify_urls(text)
        Rinku.auto_link(text)
      end

    end
  end
end
