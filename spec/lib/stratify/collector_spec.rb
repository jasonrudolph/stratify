require 'spec_helper'

class TestCollector < Stratify::Collector
  configuration_fields :username => {:type => :string},
                       :password => {:type => :password}
end

def anonymous_collector_subclass(source = "some-source")
  Class.new(Stratify::Collector).tap do |collector_class|
    collector_class.source(source)
  end
end

describe Stratify::Collector do

  before do
    Stratify::Collector.collector_classes.clear
  end

  describe ".collector_class_for" do
    it "returns the collector subclass associated with the given source" do
      example_collector_subclass = anonymous_collector_subclass("Twitter")
      Stratify::Collector.collector_classes << example_collector_subclass

      Stratify::Collector.collector_class_for("Twitter").should == example_collector_subclass
    end

    it "returns nil when no collector subclass exists for the given source" do
      Stratify::Collector.collector_class_for("lol").should be_nil
    end
  end

  describe ".sources" do
    it "returns the list of sources for all collectors" do
      Stratify::Collector.collector_classes << anonymous_collector_subclass("Foursquare")
      Stratify::Collector.collector_classes << anonymous_collector_subclass("Twitter")

      Stratify::Collector.sources.should =~ ["Foursquare", "Twitter"]
    end

    it "returns the sources in case-insensitive alphabetical order" do
      %w(Twitter iTunes Instapaper Pandora).each do |source|
        Stratify::Collector.collector_classes << anonymous_collector_subclass(source)
      end

      Stratify::Collector.sources.should == %w(Instapaper iTunes Pandora Twitter)
    end
  end

  describe ".configuration_fields" do
    it "tracks the fields used to configure the collector" do
      fields = TestCollector.configuration_fields
      fields.find {|f| f.name == :username && f.type == :string}.should be
      fields.find {|f| f.name == :password && f.type == :password}.should be
    end

    it "registers the given fields with Mongoid" do
      TestCollector.fields.should include("username", "password")
    end

    describe "influences validation" do
      it "adds an error when a collector instance fails to provide a value for each field" do
        collector = TestCollector.new
        collector.should_not be_valid
        collector.errors[:username].should include("can't be blank")
      end

      it "adds NO errors when a collector instance provides a value for each field" do
        collector = TestCollector.new(:username => "foo")
        collector.valid?
        collector.errors[:username].should_not include("can't be blank")
      end
    end
  end

  describe ".configuration_instructions (class method)" do
    it "returns the configuration instructions for a specific Collector subclass" do
      collector_subclass = anonymous_collector_subclass
      collector_subclass.configuration_instructions("Provide your username and ...")
      collector_subclass.configuration_instructions.should == "Provide your username and ..."
    end

    it "returns nil if a Collector subclass does not specify any configuration instructions" do
      anonymous_collector_subclass.configuration_instructions.should == nil
    end
  end

  describe "#configuration_instructions (instance method)" do
    it "returns the configuration instructions defined in the class" do
      collector_subclass = anonymous_collector_subclass
      collector_subclass.configuration_instructions("Provide your username and ...")
      collector = collector_subclass.new
      collector.configuration_instructions.should == "Provide your username and ..."
    end
  end

  describe "#configuration_summary" do
    context "when the collector's class has one configuration field" do
      it "returns the value of the field" do
        collector_subclass = Class.new(Stratify::Collector) do
          configuration_fields :username => {:type => :string}
        end
        collector = collector_subclass.new
        collector.username = "johndoe"
        collector.configuration_summary.should == "johndoe"
      end
    end

    context "when the collector's class has multiple configuration fields" do
      it "returns the value of the first field" do
        collector_subclass = Class.new(Stratify::Collector) do
          configuration_fields :username => {:type => :string},
                               :tag => {:type => :string}
        end
        collector = collector_subclass.new
        collector.username = "johndoe"
        collector.tag = "programming"
        collector.configuration_summary.should == "johndoe"
      end
    end

    context "when the collector's class has no configuration fields" do
      it "returns nil" do
        collector_subclass = Class.new(Stratify::Collector)
        collector = collector_subclass.new
        collector.configuration_summary.should == nil
      end
    end
  end

end
