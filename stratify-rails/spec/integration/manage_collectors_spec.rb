require 'spec_helper'

feature "Managing collectors" do
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
end
