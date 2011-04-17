class GowallaCheckin < Activity
  include Mongoid::Document

  field :checkin_id, :type => Integer
  field :spot_name
  field :spot_city_state
  field :spot_latitude, :type => BigDecimal
  field :spot_longitude, :type => BigDecimal

  natural_key :checkin_id

  validates_presence_of :checkin_id, :spot_name, :spot_latitude, :spot_longitude

  def self.new_from_api_hash(hash)
    new(
      :checkin_id => extract_id_from_checkin_url(hash.url),
      :spot_name => hash.spot.name,
      :spot_city_state => hash.spot.city_state,
      :spot_latitude => hash.spot.lat,
      :spot_longitude => hash.spot.lng,
      :created_at => hash.created_at
    )
  end

  def source
    "Gowalla"
  end
  
  def permalink
    "http://gowalla.com/checkins/#{checkin_id}"
  end

  private
  
  def self.extract_id_from_checkin_url(url)
    return unless url
    url.slice(/\d*$/) # parse the checkin_id out of the url "/checkins/18805305"
  end

end
