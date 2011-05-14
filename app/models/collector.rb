class Collector
  include Mongoid::Document
  
  field :last_ran_at, :type => DateTime

  def run
    Archiver.new(self).run
  end

  # To be implemented by subclasses
  #
  # Returns a collection of activities to be saved.
  def activities
    raise NotImplementedError
  end

  def source
    self.class.source
  end

  # Define where this collector's activities originate from (e.g., "Twitter", "iTunes")
  def self.source(src = nil)
    @source = src unless src.nil?
    @source
  end

  def self.sources
    unsorted_sources = Collector.collector_classes.map(&:source)
    unsorted_sources.sort_by {|source| source.downcase}
  end

  class << self
    attr_reader :collector_classes
  end
  
  @collector_classes = []
  
  def self.inherited(subclass)
    super
    Collector.collector_classes << subclass
  end
  
  def self.collector_class_for(source)
    Collector.collector_classes.find {|clazz| clazz.source == source}
  end
end
