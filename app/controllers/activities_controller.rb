class ActivitiesController < ApplicationController
  before_filter :prompt_user_to_setup_collectors_if_no_activities_exist, :only => :index
  before_filter :enable_pagination_for_activities, :only => :index

  def index
    @activities = Stratify::Activity.desc(:created_at).page(params[:page]).per(200)
  end

  def destroy
    @activity = Stratify::Activity.find(params[:id])
    @activity.delete
    redirect_to activities_url
  end

  private

  def enable_pagination_for_activities
    Stratify::Activity.send :include, Kaminari::MongoidExtension::Document
  end
end
