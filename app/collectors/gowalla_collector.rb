class GowallaCollector < AbstractActivityCollector
  attr_reader :username, :password

  def initialize(username, password)
    @username = username
    @password = password
  end

  def activities
    raw_activities.map {|raw_activity| build_activity_from_raw_data(raw_activity)}
  end

  private
  
  def raw_activities
    gowalla = Gowalla::Client.new(:username => username, :password => password, :api_key => 'fa574894bddc43aa96c556eb457b4009')
    gowalla.user_events
  end

  def build_activity_from_raw_data(raw_activity)
    GowallaCheckin.new_from_api_hash(raw_activity)
  end
end  
