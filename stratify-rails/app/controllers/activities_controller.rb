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
  
  private
  
  def prompt_user_to_setup_collectors_if_no_activities_exist
    if Stratify::Activity.count == 0
      flash_message = "You don't have any activities yet. Try running a collector." if Stratify::Collector.count > 0
      redirect_to(collectors_path, :notice => flash_message)
    end
  end
end