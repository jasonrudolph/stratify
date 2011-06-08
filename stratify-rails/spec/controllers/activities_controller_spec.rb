require 'spec_helper'

describe ActivitiesController do

  describe "GET index" do
    describe "when no activies exist" do
      before { Activity.stubs(:count).returns(0) }
      
      it "redirects to the collectors UI for the user to configure collectors" do
        get :index
        response.should redirect_to(collectors_path)
      end

      describe "when collectors exist" do
        it "sets a flash message instructing the user to check the collectors" do
          Collector.stubs(:count).returns(42)
          get :index
          flash[:notice].should == "You don't have any activities yet. Try running a collector."
        end
      end

      describe "when no collectors exist" do
        it "does not set a flash message" do
          Collector.stubs(:count).returns(0)
          get :index
          flash[:notice].should be_blank
        end
      end
    end
  end

  describe "DELETE destroy" do
    it "soft-deletes the requested activity" do
      activity = mock
      activity.expects(:delete)

      Activity.stubs(:find).with("42").returns(activity)
      delete :destroy, :id => "42"
    end

    it "redirects to the activities list" do
      Activity.stubs(:find).returns(stub_everything)
      delete :destroy, :id => "42"
      response.should redirect_to(activities_url)
    end
  end

end
