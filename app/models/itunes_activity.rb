class ItunesActivity < Activity
  include Mongoid::Document

  field :persistent_id, :type => Integer
  field :album
  field :artist
  field :composer
  field :genre
  field :movie, :type => Boolean
  field :name
  field :podcast, :type => Boolean
  field :track_number, :type => Integer
  field :tv_show, :type => Boolean
  field :season_number, :type => Integer
  field :year, :type => Integer

  natural_key :persistent_id, :created_at

  validates_presence_of :persistent_id

  # For TV shows, iTunes stores the episode number in the Track Number field
  alias_attribute :episode_number, :track_number

  # For TV shows, iTunes stores the show name in the Artist field
  alias_attribute :show, :artist
end
