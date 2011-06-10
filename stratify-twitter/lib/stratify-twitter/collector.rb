require 'stratify-twitter/query'

module Stratify
  module Twitter
    class Collector < Stratify::Collector
      source "Twitter"

      configuration_fields :username => {:type => :string}

      def activities
        query.activities
      end

      def query
        Stratify::Twitter::Query.new(username)
      end
    end
  end
end
