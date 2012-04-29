module Stratify
  module Garmin
    class Presenter
      delegate :title, :activity_type, :description, :to => :@activity

      def initialize(activity)
        @activity = activity
      end

      def summary
        "#{activity_type}: #{title}"
      end

      def details
        join_fields_with_separator distance, time, description
      end

      def distance
        "%0.2f miles" % @activity.distance_in_miles
      end

      def time
        minutes = @activity.time_in_seconds / 60
        seconds = @activity.time_in_seconds % 60
        "#{minutes} minutes, #{seconds} seconds"
      end

      private

      def separator
        "\u2022"
      end

      def join_fields_with_separator(*fields)
        fields.reject(&:blank?).join(" #{separator} ")
      end
    end
  end
end

