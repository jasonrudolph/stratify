require 'open-uri'
 
class ItunesCollector < Collector
  source "iTunes"

  field :library_path
  alias_method :configuration_summary, :library_path

  validates_presence_of :library_path

  validates_uniqueness_of :library_path

  def activities
    recently_played_tracks.map {|track| build_activity_from_raw_data(track)}
  end

  private
  
  def build_activity_from_raw_data(raw_activity)
    ItunesActivity.new({
      :collector => self,
      :album => raw_activity["Album"],
      :artist => raw_activity["Artist"],
      :composer => raw_activity["Composer"],
      :created_at => raw_activity["Play Date UTC"],
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
    sorted_tracks.last(50)
  end
end  
