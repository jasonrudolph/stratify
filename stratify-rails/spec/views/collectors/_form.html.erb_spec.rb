require 'spec_helper'

describe "collectors/_form.html.erb" do

  context "for a collector with configuration instructions" do
    it "renders the instructions" do
      example_collector_class = ClassFactory.collector_subclass do |subclass|
        subclass.configuration_instructions "Provide your username and ..."
      end
      assign(:collector, example_collector_class.new)

      render

      rendered.should have_css(".instructions", :text => "Provide your username and ...")
    end
  end

  context "for a collector with no configuration instructions" do
    it "does not render the instructions" do
      example_collector_class = ClassFactory.collector_subclass
      assign(:collector, example_collector_class.new)

      render

      rendered.should_not have_css(".instructions")
    end
  end
  
end
