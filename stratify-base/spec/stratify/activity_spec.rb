require 'spec_helper'

describe Stratify::Activity do

  describe "#created_on" do
    it "returns the date portion of the created_at value" do
      activity = Stratify::Activity.new(:created_at => DateTime.parse("2010-11-27 6:35 PM"))
      activity.created_on.should == Date.parse("2010-11-27")
    end

    it "returns nil if the created_at value is nil" do
      activity = Stratify::Activity.new(:created_at => nil)
      activity.created_on.should be_nil
    end
  end

  describe "#delete", :database => true do
    it "soft-deletes the activity" do
      creation_time = Time.now
      activity = Stratify::Bacon::Activity.create!(:slices => 42, :created_at => creation_time)
      activity.delete

      Stratify::Bacon::Activity.where(:slices => 42, :created_at => creation_time).should_not exist
      Stratify::Bacon::Activity.deleted.where(:slices => 42, :created_at => creation_time).should exist
    end
  end

  describe "#duplicate?", :database => true do
    class ActivityForTestingDuplicates < Stratify::Activity
      field :foo
      field :bar

      natural_key :foo, :bar
    end

    it "returns false if no record exists with the same natural key" do
      ActivityForTestingDuplicates.create!(:foo => "a", :bar => "b", :created_at => Time.now)
      ActivityForTestingDuplicates.new(:foo => "1", :bar => "2").should_not be_duplicate
    end

    it "returns true if a saved record already exists with the same natural key" do
      ActivityForTestingDuplicates.create!(:foo => "a", :bar => "b", :created_at => Time.now)
      ActivityForTestingDuplicates.new(:foo => "a", :bar => "b").should be_duplicate
    end

    it "returns true if a soft-deleted record already exists with the same natural key" do
      original = ActivityForTestingDuplicates.new(:foo => "a", :bar => "b", :created_at => Time.now)
      original.save!
      original.delete

      ActivityForTestingDuplicates.new(:foo => "a", :bar => "b").should be_duplicate
    end
  end

end
