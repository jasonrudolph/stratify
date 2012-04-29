require 'open-uri'
require 'simple-rss'
require 'stratify-garmin/rss_item_adapter'

module Stratify
  module Garmin
    class Collector < Stratify::Collector
      source "Garmin"

      configuration_fields :rss_url => {:type => :string, :label => "RSS URL"}

      configuration_instructions %q[
        <p>To collect your activities from Garmin Connect, the Garmin collector needs the RSS feed for your account.</p>

        <p>To find the URL for your personal RSS feed, go to the <a href="http://connect.garmin.com/dashboard">dashboard</a> for your Garmin Connect account. Look for the RSS icon next to your recent activities.  The URL will look something like this:</p>

        <p><code>http://connect.garmin.com/feed/rss/activities?feedname=Garmin%20Connect%20-%20johndoe&owner=johndoe</code></p>

        <p>Grab the RSS feed URL and paste it into the field below.</p>

        <p><em>Note:</em> In order for an activity to appear in your RSS feed, Garmin requires that you give the activity a title and that you make the activity public. Also, after uploading activities to Garmin Connect, it often takes several hours (sometimes even a full day) for items to show up in the RSS feed.</p>
      ]

      def activities
        activities_from_rss.map {|rss_item| activity_from_rss_item(rss_item)}
      end

      private

      def initialize_simple_rss_to_import_geo_tags
        SimpleRSS.item_tags << :"georss:point"
      end

      def activities_from_rss
        initialize_simple_rss_to_import_geo_tags
        rss = SimpleRSS.parse open(rss_url)
        rss.items
      end

      def activity_from_rss_item(item)
        adapter = Stratify::Garmin::RssItemAdapter.new(item)
        Stratify::Garmin::Activity.new(
          :title => adapter.title,
          :description => adapter.description,
          :username => adapter.username,
          :activity_type => adapter.activity_type,
          :event_type => adapter.event_type,
          :distance_in_miles => adapter.distance_in_miles,
          :time_in_seconds => adapter.time_in_seconds,
          :elevation_gain_in_feet => adapter.elevation_gain_in_feet,
          :starting_latitude => adapter.starting_latitude,
          :starting_longitude => adapter.starting_longitude,
          :guid => adapter.guid,
          :created_at => adapter.created_at
        )
      end
    end
  end
end
