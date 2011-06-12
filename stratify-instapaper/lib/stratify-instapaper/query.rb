require 'open-uri'
require 'simple-rss'

module Stratify
  module Instapaper
    class Query
      attr_reader :rss_url

      def initialize(rss_url)
        @rss_url = rss_url
      end

      def activities
        raw_activities.map {|raw_activity| build_activity_from_raw_data(raw_activity)}
      end

      private

      def raw_activities
        rss = SimpleRSS.parse open(rss_url)
        rss.items
      end

      def build_activity_from_raw_data(raw_activity)
        Stratify::Instapaper::Activity.new({
          :url => raw_activity.link, 
          :title => raw_activity.title, 
          :description => raw_activity.description, 
          :created_at => raw_activity.pubDate
        })
      end
    end
  end  
end
