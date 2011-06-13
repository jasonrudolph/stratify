require 'itunes/library'

module Stratify
  module ITunes
    class Query
      attr_reader :library_path, :limit

      def initialize(library_path, limit = 50)
        @library_path = library_path
        @limit = limit
      end

      def activities
        recently_played_tracks.map {|track| build_activity_from_raw_data(track)}
      end

      private

      def library_xml
        open(@library_path).read    
      end

      def build_activity_from_raw_data(track)
        Stratify::ITunes::Activity.new({
          :album => track.album,
          :artist => track.artist,
          :composer => track.composer,
          :created_at => track.last_played_at.to_time,
          :episode_number => track.episode_number,
          :genre => track.genre,
          :movie => track.movie?,
          :name => track.name,
          :persistent_id => track.persistent_id,
          :podcast => track.podcast?,
          :season_number => track.season_number,
          :track_number => track.number, 
          :tv_show => track.tv_show?,
          :year => track.year,
        })
      end

      def tracks
        ::ITunes::Library.load(library_xml).tracks
      end

      def played_tracks
        tracks.select { |t| t.played? }
      end

      def recently_played_tracks
        sorted_tracks = played_tracks.sort_by(&:last_played_at)
        sorted_tracks.last(limit)
      end
    end
  end  
end
