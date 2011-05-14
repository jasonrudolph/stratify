class RhapsodyCollector < Collector
  source "Rhapsody"
  
  field :rss_url
  alias_method :configuration_summary, :rss_url

  validates_presence_of :rss_url

  validates_uniqueness_of :rss_url

  def activities
    query.activities
  end

  def query
    RhapsodyQuery.new(rss_url)
  end
end