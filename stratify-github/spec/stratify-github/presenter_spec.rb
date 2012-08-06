require 'spec_helper'

describe Stratify::GitHub::Presenter do
  describe '#to_html' do
    it 'wraps a GitHub repo URL with a link' do
      data = {
        'type' => 'WatchEvent',
        'url'  => 'https://github.com/daemianmack/clj-cronviz'}
      activity  = Stratify::GitHub::Activity.from_api_hash(data)
      presenter = Stratify::GitHub::Presenter.new(activity)
      presenter.to_html.should match '<a href="https://github.com/daemianmack/clj-cronviz">https://github.com/daemianmack/clj-cronviz</a>'
    end
  end
  
end
