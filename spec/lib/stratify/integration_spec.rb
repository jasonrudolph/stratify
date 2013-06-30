require 'spec_helper'

describe "collecting activities", :database => true do
  it "runs the collector and stores activities" do
    collector = Stratify::Bacon::Collector.create!(:username => "johndoe", :password => "secret")

    expect { collector.run }.to change(Stratify::Bacon::Activity, :count).by(3)

    Stratify::Bacon::Activity.where(:slices => 3, :created_at => Time.new(2011, 4, 3, 7, 2)).should exist
    Stratify::Bacon::Activity.where(:slices => 5, :created_at => Time.new(2011, 4, 7, 8, 17)).should exist
    Stratify::Bacon::Activity.where(:slices => 4, :created_at => Time.new(2011, 4, 9, 6, 24)).should exist
  end

  it "does not import duplicate activities" do
    collector = Stratify::Bacon::Collector.new(:username => "johndoe", :password => "secret")
    expect { collector.run }.to change(Stratify::Bacon::Activity, :count).by(3)
    expect { collector.run }.to change(Stratify::Bacon::Activity, :count).by(0)
  end

  it "does not re-import soft-deleted activities" do
    collector = Stratify::Bacon::Collector.new(:username => "johndoe", :password => "secret")

    collector.run
    activity = Stratify::Bacon::Activity.where(:created_at => Time.new(2011, 4, 3, 7, 2)).first
    activity.should be
    activity.delete

    collector.run
    Stratify::Bacon::Activity.where(:created_at => Time.new(2011, 4, 3, 7, 2)).should_not exist
  end
end
