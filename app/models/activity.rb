require 'extensions/mongoid/natural_key'

class Activity
  include Mongoid::Document
  include Mongoid::Paranoia
  include Extensions::Mongoid::NaturalKey
  
  field :collector_name, :type => String
  field :created_at, :type => DateTime

  validates_presence_of :created_at

  paginates_per 200

  def collector=(collector)
    self.collector_name = collector.class.name
  end

  def collector
    return unless collector_name
    collector_name.constantize
  end

  def source
    collector.source
  end

  def permalink
    nil
  end
  
  def created_on
    return nil unless created_at
    created_at.to_date
  end

  def duplicate?
    duplicate_activities = self.class.where(natural_key_hash)
    duplicate_activities.exists? || duplicate_activities.deleted.exists?
  end
end
