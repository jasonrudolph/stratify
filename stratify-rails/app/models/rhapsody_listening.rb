class RhapsodyListening < Activity
  field :track_id # Rhapsody Track GUID / "RCID" (e.g., tra.39893452)
  field :track_title
  field :artist_id # Rhapsody Artist GUID / "RCID" (e.g., art.32992347)
  field :artist_name
  field :album_id # Rhapsody Album GUID / "RCID" (e.g., alb.39893441)
  field :album_title
  field :genre

  natural_key :track_id, :created_at
  
  validates_presence_of :track_id, :track_title, :artist_id, :artist_name, :album_id, :album_title

  def permalink
    "http://www.rhapsody.com/goto?rcid=#{track_id}"
  end
end
