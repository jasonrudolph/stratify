require 'spec_helper'

feature "Managing activities" do
  scenario "View activities" do
    Stratify::Bacon::Activity.create!(
      :slices => 3,
      :created_at => Time.parse("Sun, 12 Jun 2011 08:28 EDT"),
      :source => Stratify::Bacon::Collector.source,
    )

    visit activities_path

    within(:css, ".day") do
      page.should have_css('header.date', :text => "June 12, 2011")
      within(:css, "article.baconation") do
        page.should have_css('.data-time', :text => "8:28 am")
        page.should have_css('.data-content', :text => "Enjoyed 3 slices of delicious bacon")
      end
    end
  end

  scenario "Soft delete an activity" do
    activity = FactoryGirl.create(:bacon_activity)
    css_selector_for_activity = "article##{ActionController::RecordIdentifier.dom_id(activity)}"

    visit activities_path
    page.should have_css(css_selector_for_activity)
    within(css_selector_for_activity) { click_link("Delete") }
    page.should_not have_css(css_selector_for_activity)
  end
end
