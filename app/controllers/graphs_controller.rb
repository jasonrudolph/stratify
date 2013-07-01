class GraphsController < ApplicationController
  before_filter :prompt_user_to_setup_collectors_if_no_activities_exist

  def punch_card
    sources = Stratify::Collector.sources
    @graphs = sources.map do |source|
      activities = Stratify::Activity.where(:source => source).only(&:created_at)
      PunchCardGraphPresenter.new(source, activities)
    end
  end
end
