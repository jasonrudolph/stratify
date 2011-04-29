class TwitterCollector < Collector
  source "Twitter"

  field :username
  alias_method :configuration_summary, :username

  validates_presence_of :username

  validates_uniqueness_of :username

  def activities
    raw_activities.map {|raw_activity| build_activity_from_raw_data(raw_activity)}
  end

  private
  
  def raw_activities
    Twitter.user_timeline(username)
  end
  
  def build_activity_from_raw_data(raw_activity)
    Tweet.new({
      :collector => self,
      :status_id => raw_activity.id,
      :username => raw_activity.user.screen_name,
      :text => raw_activity.text,
      :created_at => raw_activity.created_at
    })
  end
end  
