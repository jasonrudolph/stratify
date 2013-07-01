# Be sure to restart your server when you modify this file.

require_dependency 'stratify'

# Load each collector library
Dir.glob(Rails.root.join('lib/plugins/stratify/*.rb')).each do |collector_lib|
  collector_name = File.basename(collector_lib, '.rb')
  fully_qualified_collector_name = "stratify/#{collector_name}"

  require_dependency fully_qualified_collector_name
end
