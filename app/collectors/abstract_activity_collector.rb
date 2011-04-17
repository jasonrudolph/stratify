class AbstractActivityCollector
  def run
    raw_activities.each do |raw_activity|
      create_activity_from_raw_data(raw_activity)
    end
  end

  # To be implemented by subclasses
  #
  # Return a collection of activities in their original source format 
  # (e.g., a hash from the remote API providing the actitivy data).  Each 
  # item in the collection represents a single activity.
  def raw_activities
    raise NotImplementedError 
  end
  
  protected

  def create_activity_from_raw_data(raw_activity)
    activity = build_activity_from_raw_data(raw_activity)

    # Since we run the collectors frequently, it is very common to encounter 
    # objects that we have already imported.  If this activity is a duplicate
    # of an existing object, then we skip importing this activity.
    return if activity.duplicate? 
    
    unless activity.save
      Rails.logger.error("Failed to persist activity from raw data: #{raw_activity}.\nValidation errors: #{activity.errors}")
    end
  end
  
  # To be implemented by subclasses
  # 
  # Builds an unsaved activity object from the given activity data.
  def build_activity_from_raw_data(raw_activity)
    raise NotImplementedError 
  end
end
