class ItunesActivity < Activity
  field :persistent_id, :type => Integer
  field :album
  field :artist
  field :composer
  field :genre
  field :movie, :type => Boolean
  field :name
  field :podcast, :type => Boolean
  field :track_number, :type => Integer
  field :episode_number, :type => Integer
  field :tv_show, :type => Boolean
  field :season_number, :type => Integer
  field :year, :type => Integer

  natural_key :persistent_id, :created_at

  validates_presence_of :persistent_id

  # For TV shows, iTunes stores the show name in the Artist field
  alias_attribute :show, :artist
end
