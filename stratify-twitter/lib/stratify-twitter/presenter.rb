require 'action_view'
require 'rinku'

module Stratify
  module Twitter
    class Presenter
      include ActionView::Helpers::UrlHelper
  
      def initialize(activity)
        @activity = activity
      end

      def text
        linkify_usernames(linkify_urls(@activity.text))
      end

      private

      def linkify_urls(text)
        Rinku.auto_link(text)
      end

      def linkify_usernames(text)
        text.gsub(/@\w*\b/) do |username|
          username_without_at_sign = username.delete("@")
          username_url = "http://twitter.com/#{username_without_at_sign}"
          link_to username, username_url
        end
      end
    end
  end
end
