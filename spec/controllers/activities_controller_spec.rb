require 'spec_helper'

describe ActivitiesController do

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
