module Stratify
  module Foursquare
    class Presenter
      delegate :venue_name, :venue_city, :venue_state, :to => :@activity

      def initialize(activity)
        @activity = activity
      end

      def summary
        summary_with_venue_name = "Checked in at <strong>#{venue_name}</strong>"
        has_location_info? ? "#{summary_with_venue_name} in <strong>#{location}</strong>" : summary_with_venue_name
      end

      private

      def location
        [venue_city, venue_state].reject(&:blank?).join(", ")
      end

      def has_location_info?
        !(venue_city.blank? && venue_state.blank?)
      end
    end
  end
end

