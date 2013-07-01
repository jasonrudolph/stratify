module Stratify
  module Foursquare
    class Collector < Stratify::Collector
      source "Foursquare"

      configuration_fields :oauth_token => {:type => :string}

      configuration_instructions %q[
        TODO Describe process for obtaining an OAuth token
      ]

      def activities
        query.activities
      end

      def query
        Stratify::Foursquare::Query.new(oauth_token)
      end
    end
  end
end

Stratify::Collector.collector_classes << Stratify::Foursquare::Collector
