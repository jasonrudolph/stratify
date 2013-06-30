require 'spec_helper'

describe ApplicationController do
  describe "#prompt_user_to_setup_collectors_if_no_activities_exist" do
    controller do
      before_filter :prompt_user_to_setup_collectors_if_no_activities_exist

      def index
        render :text => "bacon"
      end
    end

    describe "when no activies exist" do
      before { Stratify::Activity.stubs(:count).returns(0) }

      it "redirects to the collectors UI for the user to configure collectors" do
        get :index
        response.should redirect_to(collectors_path)
      end

      describe "when collectors exist" do
        it "sets a flash message instructing the user to check the collectors" do
          Stratify::Collector.stubs(:count).returns(42)
          get :index
          flash[:notice].should == "You don't have any activities yet. Try running a collector."
        end
      end

      describe "when no collectors exist" do
        it "does not set a flash message" do
          Stratify::Collector.stubs(:count).returns(0)
          get :index
          flash[:notice].should be_blank
        end
      end
    end

    describe "when activies exist" do
      before { Stratify::Activity.stubs(:count).returns(1) }

      it "does not redirect" do
        response.status.should == 200
      end

      it "does not set a flash message" do
        get :index
        flash[:notice].should be_blank
      end

      it "performs the action's default behavior" do
        get :index
        response.body.should == "bacon"
      end
    end
  end
end
