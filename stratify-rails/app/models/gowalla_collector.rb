class GowallaCollector < Collector
  source "Gowalla"

  configuration_fields :username => {:type => :string},
                       :password => {:type => :password}

  def activities
    query.activities
  end

  def query
    GowallaQuery.new(username, password)
  end
end
