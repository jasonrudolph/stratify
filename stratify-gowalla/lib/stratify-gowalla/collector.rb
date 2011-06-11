require 'stratify-gowalla/query'

module Stratify
  module Gowalla
    class Collector < Stratify::Collector
      source "Gowalla"

      configuration_fields :username => {:type => :string},
                           :password => {:type => :password}

      def activities
        query.activities
      end

      def query
        Stratify::Gowalla::Query.new(username, password)
      end
    end
  end
end
