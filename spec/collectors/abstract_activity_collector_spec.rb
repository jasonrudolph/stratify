require 'spec_helper'

class SampleActivityCollector < AbstractActivityCollector
end

describe AbstractActivityCollector do

  describe "persisting activities" do
    it "logs when an error is encountered attempting to persist an activity" do
      activity = stub_everything('activity', :save => false)

      collector = SampleActivityCollector.new
      collector.stubs(:build_activity_from_raw_data).returns(activity)
      
      Rails.logger.expects(:error).with() { |value| value.starts_with? "Failed to persist activity" }
      collector.send(:create_activity_from_raw_data, {})
    end

    it "does not log an error when activity is persisted successfully" do
      activity = stub_everything('activity', :save => true)

      collector = SampleActivityCollector.new
      collector.stubs(:build_activity_from_raw_data).returns(activity)
      
      Rails.logger.expects(:error).never
      collector.send(:create_activity_from_raw_data, {})
    end
  end
  
end
