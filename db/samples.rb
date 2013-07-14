# To generate sample data:
#
#   ./script/rails runner db/samples.rb

require 'securerandom'

FactoryGirl.define do
  sequence :gowalla_checkin_id do |n|
    n
  end

  sequence :rhapsody_album_id do |n|
    "alb.#{n}"
  end

  sequence :rhapsody_artist_id do |n|
    "art.#{n}"
  end

  sequence :rhapsody_track_id do |n|
    "tra.#{n}"
  end

  sequence :twitter_status_id do |n|
    n
  end

  factory :gowalla_checkin, :class => Stratify::Gowalla::Activity do
    source          Stratify::Gowalla::Collector.source
    checkin_id      { generate(:gowalla_checkin_id) }
    spot_name       { Faker::Company.name }
    spot_city_state { "#{Faker::Address.city}, #{Faker::Address.state}" }
    spot_latitude   0.0
    spot_longitude  1.1
    created_at      { rand(1000).hours.ago }
  end

  factory :instapaper_activity, :class => Stratify::Instapaper::Activity do
    source         Stratify::Instapaper::Collector.source
    url            { "http://#{Faker::Internet.domain_name}/#{Faker::Internet.domain_word}" }
    title          { Faker::Company.catch_phrase }
    description    { Faker::Lorem.paragraph }
    created_at     { rand(1000).hours.ago }
  end

  factory :itunes_activity, :class => Stratify::ITunes::Activity do
    source         Stratify::ITunes::Collector.source
    persistent_id  { SecureRandom.hex(8).upcase }
    name           { Faker::Company.catch_phrase }
    artist         { Faker::Name.name }
    album          { Faker::Company.bs.capitalize }
    genre          { ["Comedy", "Country", "Hip-Hop/Rap"].send(:rand) }
    year           { (1970..2011).to_a.send(:rand) }
    created_at     { rand(1000).hours.ago }
  end

  factory :rhapsody_activity, :class => Stratify::Rhapsody::Activity do
    source         Stratify::Rhapsody::Collector.source
    track_id       { generate(:rhapsody_track_id) }
    track_title    { Faker::Company.catch_phrase }
    artist_id      { generate(:rhapsody_artist_id) }
    artist_name    { Faker::Name.name }
    album_id       { generate(:rhapsody_album_id) }
    album_title    { Faker::Company.bs.capitalize }
    genre          { ["Comedy", "Country", "Hip-Hop"].send(:rand) }
    created_at     { rand(1000).hours.ago }
  end

  factory :tweet, :class => Stratify::Twitter::Activity do
    source         Stratify::Twitter::Collector.source
    status_id      { generate(:twitter_status_id) }
    username       "jasonrudolph"
    text           { Faker::Lorem.sentence(rand(30)).truncate(140) }
    created_at     { rand(1000).hours.ago }
  end
end

rand(20).times { FactoryGirl.create(:gowalla_checkin) }

rand(20).times { FactoryGirl.create(:tweet) }

rand(20).times do
  # Randomly determine whether to give each Instapaper reading a description
  # (since not all Instapaper articles have descriptions in the real world).
  description = [nil, Faker::Lorem.paragraph].send(:rand)
  FactoryGirl.create(:instapaper_activity, :description => description)
end

rand(20).times { FactoryGirl.create(:itunes_activity) }

rand(20).times { FactoryGirl.create(:rhapsody_activity) }
