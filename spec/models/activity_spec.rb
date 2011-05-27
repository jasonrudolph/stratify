require 'spec_helper'

describe Activity do

  describe ".default_template" do
    it "returns the contents of the file located at the default template path" do
      activity_subclass = Class.new(Activity)
      activity_subclass.stubs(:default_template_path).returns("/path/to/default/template")
      IO.stubs(:read).with("/path/to/default/template").returns("default template content")
      activity_subclass.default_template.should == "default template content"
    end
  end
  
  describe ".default_template_path" do
    it "returns the default template path based on Rails conventions" do
      activity_subclass = Class.new(Activity)
      activity_subclass.stubs(:default_template_filename).returns("_something.html.erb")
      activity_subclass.default_template_path.should == Rails.root + "app/views/activities/_something.html.erb"
    end
  end

  describe ".default_template_filename" do
    it "returns the default template filename based on Rails partial naming conventions" do
      activity_subclass = Class.new(Activity)
      activity_subclass.stubs(:name).returns("GowallaCheckin")
      activity_subclass.default_template_filename.should == "_gowalla_checkin.html.erb"
    end

    it "uses the template format to determine the filename" do
      activity_subclass = Class.new(Activity)
      activity_subclass.stubs(:name).returns("GowallaCheckin")
      activity_subclass.template_format :haml
      activity_subclass.default_template_filename.should == "_gowalla_checkin.html.haml"
    end
  end

  describe ".template" do
    it "returns the default template when no explicit template has been set" do
      activity_subclass = Class.new(Activity)
      activity_subclass.stubs(:default_template).returns(:default_template_content)
      activity_subclass.template.should == :default_template_content
    end
    
    it "returns a custom template when one has been set" do
      activity_subclass = Class.new(Activity)
      activity_subclass.template "some custom template"
      activity_subclass.template.should == "some custom template"
    end
  end
  
  describe "#created_on" do
    it "returns the date portion of the created_at value" do
      activity = Activity.new(:created_at => DateTime.parse("2010-11-27 6:35 PM"))
      activity.created_on.should == Date.parse("2010-11-27")
    end

    it "returns nil if the created_at value is nil" do
      activity = Activity.new(:created_at => nil)
      activity.created_on.should be_nil
    end
  end
  
  describe "#duplicate?" do
    class ActivityForTestingDuplicates < Activity
      field :foo
      field :bar
      
      natural_key :foo, :bar
    end

    it "returns false if no record exists with the same natural key" do
      ActivityForTestingDuplicates.create!(:foo => "a", :bar => "b", :created_at => Time.now)
      ActivityForTestingDuplicates.new(:foo => "1", :bar => "2").should_not be_duplicate
    end

    it "returns true if a saved record already exists with the same natural key" do
      ActivityForTestingDuplicates.create!(:foo => "a", :bar => "b", :created_at => Time.now)
      ActivityForTestingDuplicates.new(:foo => "a", :bar => "b").should be_duplicate
    end

    it "returns true if a soft-deleted record already exists with the same natural key" do
      original = ActivityForTestingDuplicates.new(:foo => "a", :bar => "b", :created_at => Time.now)
      original.save!
      original.delete
      
      ActivityForTestingDuplicates.new(:foo => "a", :bar => "b").should be_duplicate
    end
  end

end
