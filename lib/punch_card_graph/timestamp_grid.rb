module PunchCardGraph
  class TimestampGrid
    def initialize(timestamps)
      @timestamps = Array(timestamps)
    end

    def counts_by_day_and_hour
      counts = default_counts_by_day_and_hour
      @timestamps.each do |timestamp|
        counts[timestamp.wday][timestamp.hour] += 1
      end
      counts
    end

    private

    # Returns a two-dimensional array (7 x 24) where each cell is initialized with 0
    def default_counts_by_day_and_hour
      Array.new(7) { default_counts_by_hour }
    end

    def default_counts_by_hour
      Array.new(24, 0)
    end
  end
end
