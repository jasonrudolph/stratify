class CollectorCoordinator
  def initialize
    @collectors = []
  end
  
  def add(collector)
    @collectors << collector
  end
  
  def run
    @collectors.each do |collector|
      begin
        collector.run
      rescue => e
        Rails.logger.error("Error running collector.  Collector => #{collector}.  Error => #{e}")
      end
    end
  end
end