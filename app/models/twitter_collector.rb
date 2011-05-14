class TwitterCollector < Collector
  source "Twitter"

  field :username
  alias_method :configuration_summary, :username

  validates_presence_of :username

  validates_uniqueness_of :username

  def activities
    query.activities
  end

  def query
    TwitterQuery.new(username)
  end
end
