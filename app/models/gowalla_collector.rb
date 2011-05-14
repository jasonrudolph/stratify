class GowallaCollector < Collector
  source "Gowalla"

  field :username
  field :password
  alias_method :configuration_summary, :username

  validates_presence_of :username, :password

  validates_uniqueness_of :username

  def activities
    query.activities
  end

  def query
    GowallaQuery.new(username, password)
  end
end
