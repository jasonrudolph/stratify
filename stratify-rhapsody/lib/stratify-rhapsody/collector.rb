require 'stratify-rhapsody/query'

module Stratify
  module Rhapsody
    class Collector < Stratify::Collector
      source "Rhapsody"

      configuration_fields :rss_url => {:type => :string, :label => "RSS URL"}

      configuration_instructions %q[
        <p>To collect your Rhapsody listening history, the Rhapsody collector needs the RSS feed for your "recently played tracks."</p>

        <p>To find the URL for your personal RSS feed, go to the <a href="http://www.rhapsody.com/myrhapsody/feeds.html" target="_blank">RSS Feeds</a> page for your Rhapsody account.  Look for the RSS feed link labeled "Recently Played Tracks."  The URL will look something like this:</p>

        <p><code>http://feeds.rhapsody.com/member/ABCDEF0123456789ABCDEF0123456789/track-history.rss</code></p>

        <p>Grab the RSS feed URL for your account and paste it into the field below.</p>
      ]

      def activities
        query.activities
      end

      def query
        Stratify::Rhapsody::Query.new(rss_url)
      end
    end
  end
end
