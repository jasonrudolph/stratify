require 'spec_helper'

describe Stratify::FieldDefinition do
  describe "#name" do
    it "returns the name of the field" do
      field = Stratify::FieldDefinition.new(:username, :type => :string)
      field.name.should == :username
    end
  end

  describe "#type" do
    it "returns the type of the field" do
      field = Stratify::FieldDefinition.new(:username, :type => :string)
      field.type.should == :string
    end
  end

  describe "#label" do
    it "returns the label for the field when an explicit label is specified" do
      field = Stratify::FieldDefinition.new(:username, :type => :string, :label => "User ID")
      field.label.should == "User ID"
    end

    it "returns the titleized name for the field when no explicit label is specified" do
      field = Stratify::FieldDefinition.new(:username, :type => :string)
      field.label.should == "Username"
    end
  end
end
