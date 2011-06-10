require 'spec_helper'

def class_with_natural_key_mixin(&blk)
  Class.new do
    include Mongoid::Document
    include Stratify::MongoidExtension::NaturalKey
    yield(self) if block_given?
  end
end

describe Stratify::MongoidExtension::NaturalKey do
  describe ".natural_key" do
    context "given a single field as the key" do
      it "stores the field in an array of key fields" do
        klass = class_with_natural_key_mixin do |k|
          k.natural_key :status_id
        end
        klass.natural_key_fields.should == [:status_id]
      end
    end

    context "given a multi-field key" do
      it "stores the fields in an array of key fields" do
        klass = class_with_natural_key_mixin do |k|
          k.natural_key :url, :created_at
        end
        klass.natural_key_fields.should == [:url, :created_at]
      end
    end
    
    it "declares a uniqueness validator for the natural key" do
      klass = class_with_natural_key_mixin
      klass.expects(:validates_uniqueness_of_natural_key)
      klass.natural_key :foo
    end
  end

  describe ".validates_uniqueness_of_natural_key" do
    context "given a single field as the key" do
      it "declares that no two documents can have the same value for that field" do
        klass = class_with_natural_key_mixin
        klass.stubs(:natural_key_fields).returns [:status_id]
        klass.expects(:validates_uniqueness_of).with(:status_id)
        klass.validates_uniqueness_of_natural_key
      end
    end

    context "given a two-field key" do
      it "declares that no two documents can have the same combination of values for these two fields" do
        klass = class_with_natural_key_mixin
        klass.stubs(:natural_key_fields).returns [:url, :created_at]
        klass.expects(:validates_uniqueness_of).with(:url, :scope => [:created_at])
        klass.validates_uniqueness_of_natural_key
      end
    end

    context "given a key with more than two fields" do
      it "declares that no two documents can have the same combination of values for these fields" do
        klass = class_with_natural_key_mixin
        klass.stubs(:natural_key_fields).returns [:foo, :bar, :baz]
        klass.expects(:validates_uniqueness_of).with(:foo, :scope => [:bar, :baz])
        klass.validates_uniqueness_of_natural_key
      end
    end
  end
  
  describe "#natural_key_hash" do
    it "returns the field name and value for the object's natural key" do
      klass = class_with_natural_key_mixin do |k|
        k.field :foo
        k.field :bar
        k.field :baz
        k.natural_key :foo, :bar
      end

      model = klass.new(:foo => 1, :bar => 2, :baz => 3)
      model.natural_key_hash.should == {:foo => 1, :bar => 2}
    end
  end
end
