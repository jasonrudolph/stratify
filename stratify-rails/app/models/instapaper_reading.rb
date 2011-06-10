class InstapaperReading < Stratify::Activity
  field :url
  field :title
  field :description

  natural_key :url, :created_at
  
  validates_presence_of :url

  template %q[
    <p class="summary"><a href="<%= url %>"><%= summary %></a></p>
    <p class="details"><%= details %></p>
  ]

  def permalink
    url
  end
  
  def presenter
    InstapaperReadingPresenter.new(self)
  end
end
