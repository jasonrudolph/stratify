require 'stratify-github/events'
require 'digest/md5'

class GitHubApiError < StandardError; end

module Stratify
  module GitHub
    module Translation

      def from_api_hash(api_hash)
        activity = Stratify::GitHub::Activity.new

        activity.event_type = api_hash['type']
        activity.url        = api_hash['url']
        activity.actor      = api_hash['actor']
        activity.created_at = api_hash['created_at']

        activity.checksum   = Digest::MD5.hexdigest(activity)

        begin
          clazz = Stratify::GitHub::Event.const_get(activity.event_type)
        rescue NameError
          raise GitHubApiError, "GitHub API passed unknown type #{activity.event_type}"
        end

        activity = clazz.make(activity, api_hash)
      end
    end
  end
end
