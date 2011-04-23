class AbstractActivityCollector
  def run
    activities.each do |activity|
      persist_activity(activity)
    end
  end

  # To be implemented by subclasses
  #
  # Returns a collection of activities to be saved.
  def activities
    raise NotImplementedError
  end

  protected

  def persist_activity(activity)
    # Since we run the collectors frequently, it is very common to encounter 
    # objects that we have already imported.  If this activity is a duplicate
    # of an existing object, then we skip importing this activity.
    return if activity.duplicate? 
    
    unless activity.save
      Rails.logger.error("Failed to persist activity: #{activity}.\nValidation errors: #{activity.errors}")
    end
  end
end
