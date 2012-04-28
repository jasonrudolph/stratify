require 'foursquare2'

module Stratify
  module Foursquare
    class Query
      attr_reader :oauth_token

      def initialize(oauth_token)
        @oauth_token = oauth_token
      end

      def activities
        raw_activities.map {|raw_activity| build_activity_from_raw_data(raw_activity)}
      end

      private

      def raw_activities
        client = Foursquare2::Client.new(:oauth_token => oauth_token)
        client.user_checkins.items
      end

      def build_activity_from_raw_data(data)
        venue = data.venue
        venue_location = venue.location

        Stratify::Foursquare::Activity.new({
          :checkin_id => data.id,
          :venue_id => venue.id,
          :venue_name => venue.name,
          :venue_street => venue_location.address,
          :venue_city => venue_location.city,
          :venue_state => venue_location.state,
          :venue_postal_code => venue_location.postalCode,
          :venue_country => venue_location.country,
          :venue_latitude => venue_location.lat,
          :venue_longitude => venue_location.lng,
          :created_at => Time.at(data.createdAt)
        })
      end
    end
  end
end
