module Stratify
  module Gowalla
    class Collector < Stratify::Collector
      source "Gowalla"

      configuration_fields :username => {:type => :string},
                           :password => {:type => :password}

      configuration_instructions %q[
        Gowalla shut down on March 11, 2012. As such, there is longer any checkin data to be collected.

        This collector remains a part of Stratify soley for the purpose of accessing historical checkins collected while Gowalla was still active.

        If you're a Foursquare user, be sure to take a look at the Foursquare collector for capturing your checkin data.
      ]

      def activities
        []
      end
    end
  end
end
