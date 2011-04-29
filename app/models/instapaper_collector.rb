require 'open-uri'
 
class InstapaperCollector < Collector
  source "Instapaper"
  
  field :rss_url
  alias_method :configuration_summary, :rss_url

  validates_presence_of :rss_url

  validates_uniqueness_of :rss_url

  def activities
    raw_activities.map {|raw_activity| build_activity_from_raw_data(raw_activity)}
  end

  private

  def raw_activities
    rss = SimpleRSS.parse open(rss_url)
    rss.items
  end

  def build_activity_from_raw_data(raw_activity)
    InstapaperReading.new({
      :collector => self,
      :url => raw_activity.link, 
      :title => raw_activity.title, 
      :description => raw_activity.description, 
      :created_at => raw_activity.pubDate
    })
  end
end  
