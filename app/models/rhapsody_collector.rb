require 'open-uri'

class RhapsodyCollector < Collector
  source "Rhapsody"
  
  field :rss_url
  alias_method :configuration_summary, :rss_url

  validates_presence_of :rss_url

  validates_uniqueness_of :rss_url
  
  def activities
    raw_activities.map {|raw_activity| build_activity_from_raw_data(raw_activity)}
  end

  private
       
  def raw_activities
    initialize_simple_rss_to_import_rhapsody_tags
    rss = SimpleRSS.parse open(rss_url)
    rss.items
  end
  
  def build_activity_from_raw_data(raw_activity)    
    RhapsodyListening.new({
      :collector => self,
      :track_id => raw_activity[:"rhap_track-rcid"],
      :track_title => raw_activity[:rhap_track],
      :artist_id => raw_activity[:"rhap_artist-rcid"],
      :artist_name => raw_activity[:rhap_artist],
      :album_id => raw_activity[:"rhap_album-rcid"],
      :album_title => raw_activity[:rhap_album],
      :genre => raw_activity[:category],
      :created_at => raw_activity[:pubDate]
    })
  end

  def initialize_simple_rss_to_import_rhapsody_tags
    SimpleRSS.item_tags << :"rhap:track-rcid" << :"rhap:track" << :"rhap:artist-rcid" << :"rhap:artist"<< :"rhap:album-rcid" << :"rhap:album"
  end
end  
