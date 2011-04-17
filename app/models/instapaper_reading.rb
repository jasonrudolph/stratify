class InstapaperReading < Activity
  include Mongoid::Document

  field :url
  field :title
  field :description

  natural_key :url, :created_at
  
  validates_presence_of :url

  def source
    "Instapaper"
  end

  def domain
    URI.parse(url).host
  end
  
  def permalink
    url
  end
end
