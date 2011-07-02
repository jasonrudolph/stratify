class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def prompt_user_to_setup_collectors_if_no_activities_exist
    if Stratify::Activity.count == 0
      flash_message = "You don't have any activities yet. Try running a collector." if Stratify::Collector.count > 0
      redirect_to(collectors_path, :notice => flash_message)
    end
  end
end
