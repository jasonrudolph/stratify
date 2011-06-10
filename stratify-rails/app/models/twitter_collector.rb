class TwitterCollector < Stratify::Collector
  source "Twitter"

  configuration_fields :username => {:type => :string}

  def activities
    query.activities
  end

  def query
    TwitterQuery.new(username)
  end
end
