require 'open-uri'

module Stratify
  module GitHub
    class Collector < Stratify::Collector
      source "GitHub"

      configuration_fields :username => {:type => :string}

      def activities
        activities_from_api.map do |activity_in_api_format|
          Stratify::GitHub::Activity.from_api_hash(activity_in_api_format)
        end
      end

      private

      def activities_from_api
        JSON.parse open("https://github.com/#{username}.json").read
      end
    end
  end
end
