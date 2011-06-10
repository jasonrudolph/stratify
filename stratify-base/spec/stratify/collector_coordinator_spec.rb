require 'spec_helper'

describe Stratify::CollectorCoordinator do

  describe ".run_all" do
    it "runs all collectors" do
      collector_1 = mock(:run)
      collector_2 = mock(:run)
      
      Stratify::Collector.stubs(:all).returns([collector_1, collector_2])

      Stratify::CollectorCoordinator.run_all
    end
    
    context "when an exception occurs in a collector" do
      it "logs the exception" do
        collector = stub
        collector.stubs(:run).raises("some gnarly error") 
        Stratify::Collector.stubs(:all).returns([collector])
        
        Stratify.logger.expects(:error).with() { |value| value.include? "some gnarly error" }
        Stratify::CollectorCoordinator.run_all
      end
      
      it "runs the remaining collectors" do
        silence_stratify_logging # Silence the logger so as not to clutter the test output

        troublesome_collector = stub
        troublesome_collector.stubs(:run).raises("some gnarly error") 
        
        other_collector = mock
        other_collector.expects(:run).returns(nil)

        Stratify::Collector.stubs(:all).returns([troublesome_collector, other_collector])

        Stratify::CollectorCoordinator.run_all
      end
    end
  end

end
