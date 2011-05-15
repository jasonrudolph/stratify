class Archiver
  attr_reader :collector
  
  def initialize(collector)
    @collector = collector
  end

  def run
    collect_activities
  ensure
    record_collection_statistics
  end

  protected

  def collect_activities
    collector.activities.each do |activity|
      document_activity_source(activity)
      persist_activity(activity)
    end
  end

  def document_activity_source(activity)
    activity.source = collector.source
  end

  def persist_activity(activity)
    # Since we run the collectors frequently, it is very common to encounter 
    # objects that we have already imported.  If this activity is a duplicate
    # of an existing object, then we skip importing this activity.
    return if activity.duplicate? 

    unless activity.save
      Rails.logger.error("Failed to persist activity: #{activity}.\nValidation errors: #{activity.errors}")
    end
  end
  
  def record_collection_statistics
    collector.update_attribute :last_ran_at, Time.now
  end
end
