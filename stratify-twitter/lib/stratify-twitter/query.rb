require 'twitter'

module Stratify
  module Twitter
    class Query
      attr_reader :username
  
      def initialize(username)
        @username = username
      end

      def activities
        raw_activities.map {|raw_activity| build_activity_from_raw_data(raw_activity)}
      end

      private
  
      def raw_activities
        ::Twitter.user_timeline(username)
      end
  
      def build_activity_from_raw_data(raw_activity)
        Stratify::Twitter::Activity.new({
          :status_id => raw_activity.id,
          :username => raw_activity.user.screen_name,
          :text => raw_activity.text,
          :created_at => raw_activity.created_at
        })
      end
    end
  end  
end
