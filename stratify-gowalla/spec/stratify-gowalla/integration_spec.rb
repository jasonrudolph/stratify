require 'spec_helper'

describe "stratify-gowalla" do
  it "provides a no-op collector", :database => true do
    collector = Stratify::Gowalla::Collector.create!(:username => "jasonrudolph", :password => "secret")

    lambda do
      collector.run
    end.should_not change(Stratify::Gowalla::Activity, :count)
  end
end
