class ApplicationController < ActionController::Base
  protect_from_forgery
  around_filter :with_time_zone

  protected

  def with_time_zone(&block)
    tzinfo_zone_name = cookies["time_zone"]

    if tzinfo_zone_name.nil?
      logger.warn "Unable to determine time zone from cookie. " +
        "Using default time zone: #{Rails.application.config.time_zone}."
      yield
    else
      time_zone = time_zone_for(tzinfo_zone_name)
      Time.use_zone(time_zone, &block)
    end
  end

  # Find the name of the ActiveSupport::TimeZone that corresponds to the given
  # TZInfo time zone name.
  #
  # tzinfo_zone_name - The String name of TZInfo time zone.
  #
  # Examples
  #
  #   time_zone_for('America/New_York')
  #   # => 'Eastern Time (US & Canada)
  #
  # Returns the String representing the ActiveSupport::TimeZone name.
  def time_zone_for(tzinfo_zone_name)
    ActiveSupport::TimeZone::MAPPING.select {|k, v| v == tzinfo_zone_name}.keys.first
  end

  def prompt_user_to_setup_collectors_if_no_activities_exist
    if Stratify::Activity.count == 0
      flash_message = "You don't have any activities yet. Try running a collector." if Stratify::Collector.count > 0
      redirect_to(collectors_path, :notice => flash_message)
    end
  end
end
