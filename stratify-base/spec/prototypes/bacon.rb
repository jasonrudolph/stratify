# This file defines an example Stratify collector and activity for testing
# purposes.
#
# Stratify::Bacon::Activity and Stratify::Bacon::Collector represent a
# (fictitious, unfortunately) service for tracking your bacon-related
# achievements. This also happens to be an *amazing* idea for a service.
# You know you want to track your bacon-related achievements. You just know it.

# Stratify::Bacon::Activity implements all *mandatory* functionality required
# for it to be a valid activity.
module Stratify
  module Bacon
    class Activity < Stratify::Activity
      field :slices, :type => Integer

      natural_key :created_at

      template "Enjoyed <%= slices %> slices of delicious bacon"
    end
  end
end

# Stratify::Bacon::Collector implements all *mandatory* functionality required
# for it to be a valid collector.
module Stratify
  module Bacon
    class Collector < Stratify::Collector
      source "Baconation"

      configuration_fields :username => {:type => :string},
                           :password => {:type => :password}

      # Return a fixed set of Stratify::Bacon::Activity objects.  (A real
      # collector would tend to return new data as time goes by.  For testing
      # purposes, it's convenient to have a fixed set of data returned by the
      # collector.)
      def activities
        [
          Stratify::Bacon::Activity.new(:slices => 3, :created_at => Time.new(2011, 4, 3, 7, 2)),
          Stratify::Bacon::Activity.new(:slices => 5, :created_at => Time.new(2011, 4, 7, 8, 17)),
          Stratify::Bacon::Activity.new(:slices => 4, :created_at => Time.new(2011, 4, 9, 6, 24)),
        ]
      end
    end
  end
end
