require 'gowalla'

module Stratify
  module Gowalla
    class Query
      attr_reader :username, :password

      def initialize(username, password)
        @username = username
        @password = password
      end

      def activities
        raw_activities.map {|raw_activity| build_activity_from_raw_data(raw_activity)}
      end

      private

      def raw_activities
        gowalla = ::Gowalla::Client.new(:username => username, :password => password, :api_key => 'fa574894bddc43aa96c556eb457b4009')
        gowalla.user_events
      end

      def build_activity_from_raw_data(data)
        Stratify::Gowalla::Activity.new({
          :checkin_id => extract_id_from_checkin_url(data.url),
          :spot_name => data.spot.name,
          :spot_city_state => data.spot.city_state,
          :spot_latitude => data.spot.lat,
          :spot_longitude => data.spot.lng,
          :message => data.message,
          :created_at => data.created_at
        })
      end

      def extract_id_from_checkin_url(url)
        return unless url
        url.slice(/\d*$/) # parse the checkin_id out of the url "/checkins/18805305"
      end
    end
  end  
end
