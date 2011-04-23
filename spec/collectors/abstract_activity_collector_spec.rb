require 'spec_helper'

class SampleActivityCollector < AbstractActivityCollector
end

describe AbstractActivityCollector do

  describe "persisting activities" do
    it "logs when an error is encountered attempting to persist an activity" do
      activity = stub('activity', :duplicate? => false, :save => false, :errors => {})

      collector = SampleActivityCollector.new

      Rails.logger.expects(:error).with() { |value| value.starts_with? "Failed to persist activity" }
      collector.send(:persist_activity, activity)
    end

    it "does not log an error when activity is persisted successfully" do
      activity = stub('activity', :duplicate? => false, :save => true)

      collector = SampleActivityCollector.new

      Rails.logger.expects(:error).never
      collector.send(:persist_activity, activity)
    end
  end
  
end
