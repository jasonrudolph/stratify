class TwitterCollector < AbstractActivityCollector
  attr_reader :username

  def initialize(username)
    @username = username
  end

  def raw_activities
    Twitter.user_timeline(username)
  end
  
  def build_activity_from_raw_data(raw_activity)
    Tweet.new({
      :status_id => raw_activity.id,
      :username => raw_activity.user.screen_name,
      :text => raw_activity.text,
      :created_at => raw_activity.created_at
    })
  end
end  
