class InstapaperReading < Activity
  field :url
  field :title
  field :description

  natural_key :url, :created_at
  
  validates_presence_of :url

  def permalink
    url
  end
  
  def presenter
    InstapaperReadingPresenter.new(self)
  end
end
