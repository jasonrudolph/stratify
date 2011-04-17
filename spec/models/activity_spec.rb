describe Activity do

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
