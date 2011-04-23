require 'open-uri'
 
# An ItunesCollector pulls in your latest iTunes activity from the given
# "iTunes Music Library.xml" file.  On OS X, this file typically resides at:
# 
#   ~/Music/iTunes/iTunes Music Library.xml
# 
# To initialize the ItunesCollector, you simply need to tell it where to find
# the XML file.  To pull in activity from a local iTunes library, just provide
# the file path, and you're all set:
# 
#   ItunesCollector.new("/Users/jason/Music/iTunes/iTunes Music Library.xml")
# 
# You can also pull in activity from an iTunes XML file at a remote location;
# just provide any valid URL.
# 
#   ItunesCollector.new("http://dl.dropbox.com/u/1234567/iTunes%20Music%20Library.xml")
# 
#   ItunesCollector.new("ftp://username:password@LivingRoomMacMini.local/Music/iTunes/iTunes%20Music%20Library.xml")
# 
class ItunesCollector < AbstractActivityCollector
  attr_reader :libary_path

  def initialize(libary_path)
    @libary_path = libary_path
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
    ItunesParser.new(open(libary_path)).tracks
  end
  
  def played_tracks
    tracks.reject { |t| t["Play Date UTC"].nil? }
  end

  def recently_played_tracks
    sorted_tracks = played_tracks.sort_by { |t| t["Play Date UTC"].to_s }
    sorted_tracks.last(50)
  end
end  
