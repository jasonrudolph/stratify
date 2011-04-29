require 'spec_helper'

describe GowallaCheckin do

  describe "#permalink" do
    it "returns the URL for this checkin on Gowalla" do
      checkin = GowallaCheckin.new(:checkin_id => 26106798)
      checkin.permalink.should == "http://gowalla.com/checkins/26106798"
    end
  end
  
end
