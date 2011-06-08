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
  
  describe "GET edit" do
    it "assigns the requested collector as @collector" do
      Collector.stubs(:find).with("42").returns(stub_collector = stub)
      get :edit, :id => "42"
      assigns(:collector).should be(stub_collector)
    end
  end
  
  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested collector" do
        Collector.stubs(:find).with("42").returns(mock_collector = mock)
        mock_collector.expects(:update_attributes).with({'these' => 'params'})
        put :update, :id => "42", :collector => {'these' => 'params'}
      end

      it "redirects to the collector list" do
        Collector.stubs(:find).returns(stub(:update_attributes => true))
        put :update, :id => "42"
        response.should redirect_to(collectors_path)
      end
    end

    describe "with invalid params" do
      it "assigns the collector as @collector" do
        mock_collector = mock(:update_attributes => false)
        Collector.stubs(:find).returns(mock_collector)
        put :update, :id => "42"
        assigns(:collector).should be(mock_collector)
      end

      it "re-renders the 'edit' template" do
        mock_collector = mock(:update_attributes => false)
        Collector.stubs(:find).returns(mock_collector)
        put :update, :id => "42"
        response.should render_template("edit")
      end
    end
  end
  
  describe "DELETE destroy" do
    it "deletes the requested collector" do
      collector = mock
      collector.expects(:delete)

      Collector.stubs(:find).with("42").returns(collector)
      delete :destroy, :id => "42"
    end

    it "redirects to the collector list" do
      Collector.stubs(:find).returns(stub_everything)
      delete :destroy, :id => "42"
      response.should redirect_to(collectors_path)
    end
  end
end
