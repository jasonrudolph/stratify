require 'spec_helper'

def anonymous_class_with_renderable_mixin
  Class.new do
    include Stratify::Renderable
  end
end

describe Stratify::Renderable do
  describe ".template" do
    it "returns the template specified for use in rendering the object" do
      renderable_class = anonymous_class_with_renderable_mixin
      renderable_class.template "some custom template"
      renderable_class.template.should == "some custom template"
    end
  end

  describe ".template_format" do
    it "returns ':erb' when no explicit format has been set" do
      renderable_class = anonymous_class_with_renderable_mixin
      renderable_class.template_format.should == :erb
    end

    it "returns a custom template format when one has been set" do
      renderable_class = anonymous_class_with_renderable_mixin
      renderable_class.template_format :haml
      renderable_class.template_format.should == :haml
    end
  end
  
  describe "#presenter" do
    it "returns the object" do
      renderable_object = anonymous_class_with_renderable_mixin.new
      renderable_object.presenter.should == renderable_object
    end
  end

  describe "#to_html" do
    it "returns the result of rendering the template with the presenter" do
      renderable_class = anonymous_class_with_renderable_mixin
      renderable_class.template "Hello, <%= name %>"

      renderable_object = renderable_class.new
      class << renderable_object
        def name
          "Kilgore"
        end
      end
      
      renderable_object.to_html.should == "Hello, Kilgore"
    end
  end
end
