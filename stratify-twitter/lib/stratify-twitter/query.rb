require 'twitter'

module Stratify
  module Twitter
    class Query
      attr_reader :username
  
      def initialize(username)
        @username = username
      end

      def activities
        status_updates_from_api.map {|status_update| build_activity_from_api_response_hash(status_update)}
      end

      private
  
      def status_updates_from_api
        ::Twitter.user_timeline(username, :include_rts => true)
      end

      def build_activity_from_api_response_hash(api_hash)
        attribute_hash = build_status_update_hash(api_hash)
        Stratify::Twitter::Activity.new(attribute_hash)
      end
  
      def build_status_update_hash(api_response_hash)
        return nil if api_response_hash.nil?
        
        {
          :status_id => api_response_hash.id,
          :username => api_response_hash.user.screen_name,
          :text => api_response_hash.text,
          :created_at => api_response_hash.created_at,
          :retweeted_status => build_status_update_hash(api_response_hash[:retweeted_status])
        }
      end
    end
  end  
end
