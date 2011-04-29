require 'spec_helper'

describe CollectorsHelper do
  describe "determining the form partial to use for a given collector source" do
    example { helper.form_partial_for_source("Twitter").should == "twitter_form" }

    example { helper.form_partial_for_source("iTunes").should == "itunes_form" }
  end
end
