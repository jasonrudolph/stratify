class ItunesCollector < Collector
  source "iTunes"

  field :library_path
  alias_method :configuration_summary, :library_path

  validates_presence_of :library_path

  validates_uniqueness_of :library_path

  def activities
    query.activities
  end

  def query
    ItunesQuery.new(library_path)
  end
end