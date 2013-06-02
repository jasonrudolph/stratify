module ClassFactory
  def self.collector_subclass(&blk)
    Class.new(Stratify::Collector) do
      source "SomeExampleSource"
      yield self if block_given?
    end
  end
end
