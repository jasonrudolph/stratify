require 'spec_helper'

# TODO Replace with a "factory" that provides a default collector subclass for testing
example_collector_class = Class.new(Collector) do
  configuration_fields :username => {:type => :string}
end

describe "collectors/_form.html.erb" do
  context "for a collector with configuration instructions" do
    it "renders the instructions" do
      collector_class = example_collector_class
      collector_class.stubs(:configuration_instructions).returns("Provide your username and ...")
      assign(:collector, collector_class.new)

      render

      rendered.should have_css(".instructions", :text => "Provide your username and ...")
    end
  end

  context "for a collector with no configuration instructions" do
    it "does not render the instructions" do
      assign(:collector, example_collector_class.new)

      render

      rendered.should_not have_css(".instructions")
    end
  end
  
end