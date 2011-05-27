class Tweet < Activity
  field :status_id, :type => Integer
  field :username
  field :text

  natural_key :status_id
  
  validates_presence_of :status_id, :username, :text
  
  def permalink
    "http://twitter.com/#{username}/status/#{status_id}"
  end
  
  def to_html
    TweetPresenter.new(self).text
  end
end
