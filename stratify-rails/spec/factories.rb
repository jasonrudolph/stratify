Factory.sequence :gowalla_checkin_id do |n| 
  n
end

Factory.sequence :rhapsody_album_id do |n| 
  "alb.#{n}"
end

Factory.sequence :rhapsody_artist_id do |n| 
  "art.#{n}"
end

Factory.sequence :rhapsody_track_id do |n| 
  "tra.#{n}"
end

Factory.sequence :tweet_status_id do |n| 
  n
end

Factory.define :gowalla_checkin, :class => Stratify::Gowalla::Activity do |f|
  f.source          Stratify::Gowalla::Collector.source
  f.checkin_id      { Factory.next :gowalla_checkin_id }
  f.spot_name       { Faker::Company.name }
  f.spot_city_state { "#{Faker::Address.city}, #{Faker::Address.state}" }
  f.spot_latitude   0.0
  f.spot_longitude  1.1
  f.created_at      { rand(1000).hours.ago }
end

Factory.define :instapaper_reading, :class => Stratify::Instapaper::Activity do |f|
  f.source         Stratify::Instapaper::Collector.source
  f.url            { "http://#{Faker::Internet.domain_name}/#{Faker::Internet.domain_word}" }
  f.title          { Faker::Company.catch_phrase }
  f.description    { Faker::Lorem.paragraph }
  f.created_at     { rand(1000).hours.ago }
end

Factory.define :itunes_activity, :class => Stratify::ITunes::Activity do |f|
  f.source         Stratify::ITunes::Collector.source
  f.persistent_id  { ActiveSupport::SecureRandom.hex(8).upcase }
  f.name           { Faker::Company.catch_phrase }
  f.artist         { Faker::Name.name }
  f.album          { Faker::Company.bs.capitalize }
  f.genre          { ["Comedy", "Country", "Hip-Hop/Rap"].rand }
  f.year           { (1970..2011).to_a.rand }
  f.created_at     { rand(1000).hours.ago }
end

Factory.define :rhapsody_listening, :class => Stratify::Rhapsody::Activity do |f|
  f.source         Stratify::Rhapsody::Collector.source
  f.track_id       { Factory.next :rhapsody_track_id }
  f.track_title    { Faker::Company.catch_phrase }
  f.artist_id      { Factory.next :rhapsody_artist_id }
  f.artist_name    { Faker::Name.name }
  f.album_id       { Factory.next :rhapsody_album_id }
  f.album_title    { Faker::Company.bs.capitalize }
  f.genre          { ["Comedy", "Country", "Hip-Hop"].rand }
  f.created_at     { rand(1000).hours.ago }
end

Factory.define :tweet, :class => Stratify::Twitter::Activity do |f|
  f.source         Stratify::Twitter::Collector.source
  f.status_id      { Factory.next :tweet_status_id }
  f.username       "jasonrudolph"
  f.text           { Faker::Lorem.sentence(rand(30)).truncate(140) }
  f.created_at     { rand(1000).hours.ago }
end
