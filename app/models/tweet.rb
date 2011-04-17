class Tweet < Activity
  include Mongoid::Document

  field :status_id, :type => Integer
  field :username
  field :text

  natural_key :status_id
  
  validates_presence_of :status_id, :username, :text
  
  def source
    "Twitter"
  end
  
  def permalink
    "http://twitter.com/#{username}/status/#{status_id}"
  end
end
