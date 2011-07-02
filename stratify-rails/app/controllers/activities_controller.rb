class ActivitiesController < ApplicationController
  before_filter :prompt_user_to_setup_collectors_if_no_activities_exist, :only => :index

  def index
    @activities = Stratify::Activity.desc(:created_at).page params[:page]
  end

  def destroy
    @activity = Stratify::Activity.find(params[:id])
    @activity.delete
    redirect_to activities_url
  end
end