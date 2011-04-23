require 'open-uri'
 
class InstapaperCollector < AbstractActivityCollector
  attr_reader :rss_url_suffix

  def initialize(rss_url_suffix)
    @rss_url_suffix = rss_url_suffix
  end

  def activities
    raw_activities.map {|raw_activity| build_activity_from_raw_data(raw_activity)}
  end

  private

  def url
    "http://www.instapaper.com/archive/rss/" + rss_url_suffix
  end

  def raw_activities
    rss = SimpleRSS.parse open(url)
    rss.items
  end

  def build_activity_from_raw_data(raw_activity)
    InstapaperReading.new({
      :url => raw_activity.link, 
      :title => raw_activity.title, 
      :description => raw_activity.description, 
      :created_at => raw_activity.pubDate
    })
  end
end  
