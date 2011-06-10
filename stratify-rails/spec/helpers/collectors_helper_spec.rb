require 'spec_helper'

describe CollectorsHelper do
  describe "form_url_for" do
    describe "with a new collector" do
      it "returns /collectors" do
        helper.form_url_for(Stratify::Collector.new).should == collectors_path
      end
    end

    describe "with an existing collector" do
      it "returns a URL with the pattern /collectors/:id" do
        collector = Stratify::Collector.new
        collector.stubs(:persisted? => true)
        collector.stubs(:id => 42)
        helper.form_url_for(collector).should == "/collectors/42"
      end
    end
  end
end
