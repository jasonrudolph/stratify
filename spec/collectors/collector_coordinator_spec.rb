require 'spec_helper'

describe CollectorCoordinator do
  describe "#run" do
    context "when an exception occurs in a collector" do
      it "logs the exception" do
        collector = stub
        collector.stubs(:run).raises("some gnarly error") 

        cc = CollectorCoordinator.new
        cc.add collector
        
        Rails.logger.expects(:error).with() { |value| value.include? "some gnarly error" }
        cc.run
      end
      
      it "runs the remaining collectors" do
        troublesome_collector = stub
        troublesome_collector.stubs(:run).raises("some gnarly error") 
        
        other_collector = mock
        other_collector.expects(:run).returns(nil)

        cc = CollectorCoordinator.new
        cc.add troublesome_collector
        cc.add other_collector

        cc.run
      end
    end
  end
end
