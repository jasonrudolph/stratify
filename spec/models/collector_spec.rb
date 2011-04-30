require 'spec_helper'

def anonymous_collector_subclass
  Class.new(Collector)
end

describe Collector do

  describe ".run" do
    context "when the collection succeeds" do
      it "updates the last_ran_at timestamp for the collector" do
        stub_current_timestamp = Time.parse "2011-04-30 14:11:02"
        Time.stubs(:now).returns stub_current_timestamp
        
        collector = Collector.create
        collector.stubs(:collect_activities)
        collector.run
        collector.last_ran_at.should == stub_current_timestamp
      end
    end

    context "when an exception occurs during collection" do
      it "propagates the exception to the caller" do
        collector = Collector.create
        collector.stubs(:collect_activities).raises("some gnarly error") 
        lambda { collector.run }.should raise_error
      end

      it "updates the last_ran_at timestamp for the collector" do
        stub_current_timestamp = Time.parse "2011-04-30 14:11:02"
        Time.stubs(:now).returns stub_current_timestamp

        collector = Collector.create
        collector.stubs(:collect_activities).raises("some gnarly error") 
        collector.run rescue nil
        collector.last_ran_at.should == stub_current_timestamp
      end
    end
  end

  describe ".collector_class_for" do
    example do 
      TwitterCollector # make sure the collector class is loaded
      Collector.collector_class_for("Twitter").should == TwitterCollector
    end

    example do
      ItunesCollector # make sure the collector class is loaded
      Collector.collector_class_for("iTunes").should == ItunesCollector
    end

    it "returns nil when no collector class exists for the given source" do
      Collector.collector_class_for("lol").should be_nil
    end
  end

  describe ".sources" do
    before { Collector.collector_classes.clear }
    
    it "returns the list of sources for all collectors" do
      anonymous_collector_subclass.source("FourSquare")
      anonymous_collector_subclass.source("Twitter")
      Collector.sources.should =~ ["FourSquare", "Twitter"]
    end
    
    it "returns the sources in case-insensitive alphabetical order" do
      anonymous_collector_subclass.source("Twitter")
      anonymous_collector_subclass.source("iTunes")
      anonymous_collector_subclass.source("Instapaper")
      anonymous_collector_subclass.source("Pandora")
      Collector.sources.should == %w(Instapaper iTunes Pandora Twitter)
    end
  end

  describe "persisting activities" do
    it "logs when an error is encountered attempting to persist an activity" do
      activity = stub('activity', :duplicate? => false, :save => false, :errors => {})

      collector = anonymous_collector_subclass.new

      Rails.logger.expects(:error).with() { |value| value.starts_with? "Failed to persist activity" }
      collector.send(:persist_activity, activity)
    end

    it "does not log an error when activity is persisted successfully" do
      activity = stub('activity', :duplicate? => false, :save => true)

      collector = anonymous_collector_subclass.new

      Rails.logger.expects(:error).never
      collector.send(:persist_activity, activity)
    end
  end
  
end
