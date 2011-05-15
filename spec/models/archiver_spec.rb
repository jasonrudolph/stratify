describe Archiver do

  describe ".run" do
    context "when the collection succeeds" do
      it "updates the last_ran_at timestamp for the collector" do
        stub_current_timestamp = Time.parse "2011-04-30 14:11:02"
        Time.stubs(:now).returns stub_current_timestamp

        collector = Collector.create
        archiver = Archiver.new(collector)
        archiver.stubs(:collect_activities)
        archiver.run
        collector.last_ran_at.should == stub_current_timestamp
      end
    end

    context "when an exception occurs during collection" do
      it "propagates the exception to the caller" do
        archiver = Archiver.new(collector = stub)
        archiver.stubs(:collect_activities).raises("some gnarly error") 
        lambda { archiver.run }.should raise_error
      end

      it "updates the last_ran_at timestamp for the collector" do
        stub_current_timestamp = Time.parse "2011-04-30 14:11:02"
        Time.stubs(:now).returns stub_current_timestamp

        collector = Collector.create
        archiver = Archiver.new(collector)
        archiver.stubs(:collect_activities).raises("some gnarly error") 
        archiver.run rescue nil
        collector.last_ran_at.should == stub_current_timestamp
      end
    end
  end
  
  describe ".collect_activities" do
    it "documents the source of each activity" do
      example_collector_class = Class.new(Collector)
      example_collector_class.source("some-example-source")
      collector = example_collector_class.new

      activity = Activity.new
      collector.stubs(:activities).returns [activity]
      
      archiver = Archiver.new(collector)
      archiver.stubs(:persist_activity)
      archiver.send(:collect_activities)
      activity.source.should == "some-example-source"
    end
    
    it "persists each activity" do
      collector = Collector.new
      activity = Activity.new
      collector.stubs(:activities).returns [activity]
      
      archiver = Archiver.new(collector)
      archiver.expects(:persist_activity).with(activity)
      archiver.send(:collect_activities)
    end
  end

  describe "persisting activities" do
    it "logs when an error is encountered attempting to persist an activity" do
      activity = stub('activity', :duplicate? => false, :save => false, :errors => {})

      archiver = Archiver.new(collector = stub)

      Rails.logger.expects(:error).with() { |value| value.starts_with? "Failed to persist activity" }
      archiver.send(:persist_activity, activity)
    end

    it "does not log an error when activity is persisted successfully" do
      activity = stub('activity', :duplicate? => false, :save => true)

      archiver = Archiver.new(collector = stub)

      Rails.logger.expects(:error).never
      archiver.send(:persist_activity, activity)
    end
  end

end