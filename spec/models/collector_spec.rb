require 'spec_helper'

def anonymous_collector_subclass
  Class.new(Collector)
end

describe Collector do

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
  
end
