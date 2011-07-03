module Stratify
  module Twitter
    module Translation
      def from_api_hash(api_hash)
        activity = Stratify::Twitter::Activity.new

        activity.status_id = api_hash.id
        activity.username = api_hash.user.screen_name
        activity.text = api_hash.text
        activity.created_at = api_hash.created_at

        if api_hash[:retweeted_status]
          activity.retweeted_status = {
            :status_id => api_hash[:retweeted_status].id,
            :username => api_hash[:retweeted_status].user.screen_name,
            :text => api_hash[:retweeted_status].text,
          }
        end

        activity
      end
    end
  end
end
