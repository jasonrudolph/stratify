require 'factory_girl'
require Rails.root.join("spec", "factories.rb")

rand(20).times { Factory(:gowalla_checkin) }

rand(20).times { Factory(:tweet) }

rand(20).times do
  # Randomly determine whether to give each Instapaper reading a description
  # (since not all Instapaper articles have descriptions in the real world).
  description = [nil, Faker::Lorem.paragraph].rand
  Factory(:instapaper_reading, :description => description)
end

rand(20).times { Factory(:itunes_activity) }

rand(20).times { Factory(:rhapsody_listening) }
