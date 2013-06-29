require 'spec_helper'

describe 'stratify-github' do
  use_vcr_cassette 'github'

  it 'collects and stores events from GitHub', :database => true do
    collector = Stratify::GitHub::Collector.create!(:username => 'daemianmack')
    collector.run

    Stratify::GitHub::Activity.where(
      :actor      => 'daemianmack',
      :event_type => 'ForkEvent',
      :url        => 'https://github.com/daemianmack/stratify'
    ).should exist
  end
end
