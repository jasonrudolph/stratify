require 'spec_helper'

feature "Managing collectors" do
  before do
    Stratify::Collector.collector_classes.clear
    Stratify::Collector.collector_classes << Stratify::Bacon::Collector
  end

  scenario "Add a collector" do
    visit collectors_path

    page.select "Baconation", :from => "collector[source]"
    click_button("Add collector")

    page.should have_content("New Baconation Collector")

    fill_in("Username", :with => "johndoe")
    fill_in("Password", :with => "secret")
    click_button("Save")

    current_path.should == collectors_path
    within(:css, ".collector") do
      page.should have_css('.collector-source', :text => "Baconation")
      page.should have_css('.collector-configuration', :text => "johndoe")
    end
  end

  scenario "Edit a collector" do
    collector = Stratify::Bacon::Collector.create!(:username => "johndoe", :password => "password")

    visit "/collectors/#{collector.id}/edit"

    page.should have_content("Editing Baconation Collector")

    fill_in("Username", :with => "kilgore")
    fill_in("Password", :with => "secret")
    click_button("Save")

    current_path.should == collectors_path
    within(:css, ".collector") do
      page.should have_css('.collector-source', :text => "Baconation")
      page.should have_css('.collector-configuration', :text => "kilgore")
    end
  end

  scenario "Delete a collector" do
    collector = Stratify::Bacon::Collector.create!(:username => "johndoe", :password => "password")
    css_selector_for_collector = "##{ActionController::RecordIdentifier.dom_id(collector)}"

    visit collectors_path

    page.should have_css(css_selector_for_collector)
    within(css_selector_for_collector) { click_link("Delete") }

    current_path.should == collectors_path
    page.should_not have_css(css_selector_for_collector)
  end
end
