require 'twitter'

module Stratify
  module Twitter
    class Collector < Stratify::Collector
      source "Twitter"

      configuration_fields :username => {:type => :string}

      def activities
        activities_from_api.map do |activity_in_api_format|
          Stratify::Twitter::Activity.from_api_hash(activity_in_api_format)
        end
      end

      private

      def activities_from_api
        ::Twitter.user_timeline(username, :include_rts => true)
      end
    end
  end
end
