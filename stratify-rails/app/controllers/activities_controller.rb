class ActivitiesController < ApplicationController
  before_filter :prompt_user_to_setup_collectors_if_no_activities_exist, :only => :index

  def index
    # TODO Simplify the logic below once this bug is fixed in Kaminari:
    #      https://github.com/amatsuda/kaminari/issues/145
    activity_criteria = Stratify::Activity.desc(:created_at)
    @activities = Kaminari.paginate_array(activity_criteria).page(params[:page]).per(200)
  end

  def destroy
    @activity = Stratify::Activity.find(params[:id])
    @activity.delete
    redirect_to activities_url
  end
end
