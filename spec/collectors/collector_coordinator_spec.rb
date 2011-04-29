require 'spec_helper'

describe CollectorCoordinator do
  describe ".run_all" do
    context "when an exception occurs in a collector" do
      it "logs the exception" do
        collector = stub
        collector.stubs(:run).raises("some gnarly error") 
        Collector.stubs(:all).returns([collector])
        
        Rails.logger.expects(:error).with() { |value| value.include? "some gnarly error" }
        CollectorCoordinator.run_all
      end
      
      it "runs the remaining collectors" do
        troublesome_collector = stub
        troublesome_collector.stubs(:run).raises("some gnarly error") 
        
        other_collector = mock
        other_collector.expects(:run).returns(nil)

        Collector.stubs(:all).returns([troublesome_collector, other_collector])

        CollectorCoordinator.run_all
      end
    end
  end
end
