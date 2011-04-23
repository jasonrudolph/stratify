require 'open-uri'

class RhapsodyCollector < AbstractActivityCollector
  attr_reader :rss_member_id
  
  def initialize(rss_member_id)
    @rss_member_id = rss_member_id
  end

  def activities
    raw_activities.map {|raw_activity| build_activity_from_raw_data(raw_activity)}
  end

  private
  
  def url
    "http://feeds.rhapsody.com/member/#{rss_member_id}/track-history.rss"
  end
       
  def raw_activities
    initialize_simple_rss_to_import_rhapsody_tags
    rss = SimpleRSS.parse open(url)
    rss.items
  end
  
  def build_activity_from_raw_data(raw_activity)    
    RhapsodyListening.new({
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
