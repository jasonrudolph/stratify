require 'open-uri'
 
class ItunesQuery
  attr_reader :library_path, :limit

  def initialize(library_path, limit = 50)
    @library_path = library_path
    @limit = limit
  end

  def activities
    recently_played_tracks.map {|track| build_activity_from_raw_data(track)}
  end

  private
  
  def build_activity_from_raw_data(raw_activity)
    ItunesActivity.new({
      :album => raw_activity["Album"],
      :artist => raw_activity["Artist"],
      :composer => raw_activity["Composer"],
      :created_at => raw_activity["Play Date UTC"],
      :episode_number => raw_activity["Episode Order"],
      :genre => raw_activity["Genre"],
      :movie => raw_activity["Movie"],
      :name => raw_activity["Name"],
      :persistent_id => raw_activity["Persistent ID"],
      :podcast => raw_activity["Podcast"],
      :season_number => raw_activity["Season"],
      :track_number => raw_activity["Track Number"],
      :tv_show => raw_activity["TV Show"],
      :year => raw_activity["Year"],
    })
  end

  def tracks
    ItunesParser.new(open(library_path)).tracks
  end
  
  def played_tracks
    tracks.reject { |t| t["Play Date UTC"].nil? }
  end

  def recently_played_tracks
    sorted_tracks = played_tracks.sort_by { |t| t["Play Date UTC"].to_s }
    sorted_tracks.last(limit)
  end
end  
