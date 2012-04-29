require 'spec_helper'

describe PunchCardGraphPresenter do
  describe "#source" do
    it "returns the name of the source for the graph's activities" do
      graph = PunchCardGraphPresenter.new("Bacon", [])
      graph.source.should == "Bacon"
    end
  end

  describe "#url" do
    it "initializes a PunchCardGraph::Builder with the activity's timestamps" do
      timestamp_1 = 1.day.ago
      timestamp_2 = 2.days.ago
      timestamp_3 = 3.days.ago

      activity_1 = stub(:created_at => timestamp_1)
      activity_2 = stub(:created_at => timestamp_2)
      activity_3 = stub(:created_at => timestamp_3)

      builder = stub(:to_url => "")

      PunchCardGraph::Builder.expects(:new).with() do |args|
        args[:timestamps].should =~ [timestamp_1, timestamp_2, timestamp_3]
      end.returns(builder)

      graph = PunchCardGraphPresenter.new("source", [activity_1, activity_2, activity_3])
      graph.url
    end

    it "returns the graph URL provided by the PunchCardGraph::Builder" do
      builder = stub(:to_url => "punch-card-graph-url")
      PunchCardGraph::Builder.stubs(:new).returns(builder)

      graph = PunchCardGraphPresenter.new("source", [])
      graph.url.should == "punch-card-graph-url"
    end
  end
end
