# Be sure to restart your server when you modify this file.

require 'stratify/base'

# Load each collector library
Dir.glob(Rails.root.join('lib/stratify/*.rb')).each do |collector_lib|
  require collector_lib
end
