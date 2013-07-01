module Stratify
  module Instapaper
    class Collector < Stratify::Collector
      source "Instapaper"

      configuration_fields :rss_url => {:type => :string, :label => "RSS URL"}

      configuration_instructions %q[
        <p>To collect the articles that you've read on Instapaper, the Instapaper collector needs the RSS feed for your archived articles.</p>

        <p>To find the URL for your personal RSS feed, go to the <a href="http://www.instapaper.com/archive" target="_blank">archive for your Instapaper account</a>.  Look for the RSS feed link on that page.  (You should find it toward the bottom right of the page.)  The URL will look something like this:</p>

        <p><code>http://www.instapaper.com/archive/rss/123456/0123456789abcdefghijklmnopq</code></p>

        <p>Grab the RSS feed URL for your account and paste it into the field below.</p>
      ]

      def activities
        query.activities
      end

      def query
        Stratify::Instapaper::Query.new(rss_url)
      end
    end
  end
end

Stratify::Collector.collector_classes << Stratify::Instapaper::Collector
