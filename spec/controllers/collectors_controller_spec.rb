require 'spec_helper'

describe CollectorsController do
  describe "GET new" do
    it "assigns a new collector for the specified source as @collector" do
      example_collector_class = Class.new(Collector)
      Collector.stubs(:collector_class_for).with("Twitter").returns(example_collector_class)
      get :new, :collector => {:source => "Twitter"}
      assigns(:collector).should be_instance_of(example_collector_class)
    end

    it "quietly redirects if the request specifies an invalid source" do
      get :new, :collector => {:source => "some-invalid-source-name"}
      response.should redirect_to(collectors_path)
    end
  end

  describe "POST create" do
    describe "with invalid params" do
      before do
        @example_collector_class = Class.new(Collector)
        Collector.stubs(:collector_class_for).returns(@example_collector_class)
      end

      it "assigns a newly created but unsaved collector as @collector" do
        example_collector = stub(:save => false)
        @example_collector_class.stubs(:new).with("these" => "params").returns(example_collector)
        post :create, :collector => {"these" => "params"}
        assigns(:collector).should be(example_collector)
      end

      it "re-renders the 'new' template" do
        example_collector = stub(:save => false)
        @example_collector_class.stubs(:new).returns(example_collector)
        post :create, :collector => {}
        response.should render_template("new")
      end
    end
  end  
end
