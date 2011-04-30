class ActivitiesController < ApplicationController
  before_filter :prompt_user_to_setup_collectors_if_no_activities_exist, :only => :index

  def index
    @activities = Activity.desc(:created_at).page params[:page]
  end

  def destroy
    @activity = Activity.find(params[:id])
    @activity.delete
    redirect_to activities_url
  end
  
  private
  
  def prompt_user_to_setup_collectors_if_no_activities_exist
    redirect_to collectors_path if Activity.count == 0
  end
end